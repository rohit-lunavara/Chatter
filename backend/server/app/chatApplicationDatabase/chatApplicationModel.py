from . import User, Message
from config import DevelopmentConfig
from email_validator import validate_email
import hashlib
import logging
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship, backref


def trimAndHashPassword(password):
    md5Hashlib = hashlib.md5()
    md5Hashlib.update(password.strip().encode("utf-8"))
    return md5Hashlib.hexdigest()


class ChatApplicationModel(object):
    """Provides methods that implement functionality of the ChatApplication Service."""

    PASSWORD_LIMIT = 8

    def __init__(self, config):
        databaseEngine = create_engine(config.DATABASE_URI)
        Session = sessionmaker(databaseEngine)
        self.session = Session()

    def _getUser(self, email, password):
        return self.session.query(User).filter(
            User.email == email, User.password == trimAndHashPassword(password)).first()

    def createUser(self, email, password):
        """
        Creates a user if a unique email address is provided
        """
        # Validate email
        try:
            validate_email(email)
        except:
            # raise ValueError('Invalid email address')
            # TODO - Logging
            # print("Email invalid")
            return False

        # Check if email already exists
        user = self.session.query(User).filter(User.email == email).first()
        if user:
            # raise ValueError("Email already exists")
            # TODO - Logging
            # print("Email already exists")
            return False

        if len(password) < ChatApplicationModel.PASSWORD_LIMIT:
            # raise ValueError("Password too short")
            # TODO - Logging
            # print("Password too short")
            return False

        # Create User
        newUser = User(email=email, password=trimAndHashPassword(password))
        self.session.add(newUser)
        self.session.commit()

        return True

    def verifyCredentials(self, email, password):
        """
        Verifies whether the email matches the password
        """
        # Validate email is not empty or null
        if not email:
            # raise ValueError('No email address provided')
            # TODO - Logging
            # print("No email provided")
            return False

        # Check if email exists
        user = self.session.query(User).get(email)
        if not user:
            # raise ValueError("Incorrect Email provided")
            # TODO - Logging
            # print("Incorrect email provided")
            return False

        # Check if user exists
        user = self._getUser(email, password)
        if not user:
            # raise ValueError("Authentication Error")
            # TODO - Logging
            # print("Incorrect password provided")
            return False

        return True

    def createMessage(self, email, password, message):
        """
        Creates a message
        """

        user = self._getUser(email, password)
        if user:
            newMessage = Message(message=message)
            user.messages.append(newMessage)
            self.session.add(newMessage)
            self.session.add(user)
            self.session.commit()
            return True

        return False

    def getMessages(self, email, password):
        """
        Generates a message stream
        """

        user = self._getUser(email, password)
        if user:
            allMessagesQuery = self.session.query(Message)
            return allMessagesQuery

        return []
