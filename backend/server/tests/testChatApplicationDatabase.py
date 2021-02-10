import contextlib
import hashlib
from app.chatApplicationDatabase.chatApplicationModel import ChatApplicationModel
from app.chatApplicationDatabase import createDatabase
from config import config
from sqlalchemy import create_engine, MetaData
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy_utils import database_exists, drop_database
import unittest

Base = declarative_base()

class TestChatApplicationDatabase(unittest.TestCase):
    # Setup and Teardown
    def _createDatabase(self):
        createDatabase(self.testConfig)

    def _dropDatabase(self):
        if database_exists(self.testConfig.DATABASE_URI):
            drop_database(self.testConfig.DATABASE_URI)

    def setUp(self):
        self.testConfig = config["test"]

        self._createDatabase()
        self.model = ChatApplicationModel(self.testConfig)

    def tearDown(self):
        self._dropDatabase()

    # Test Methods
    def testCreateUser(self):
        isUserCreated = self.model.createUser("rohit.lunavara@gmail.com", "reset123")
        self.assertTrue(isUserCreated)

    def testCreateDuplicateUser(self):
        isUserCreated = self.model.createUser("rohit.lunavara@gmail.com", "reset123")
        self.assertTrue(isUserCreated)

        isUserCreatedTwice = self.model.createUser("rohit.lunavara@gmail.com", "reset")
        self.assertFalse(isUserCreatedTwice)

    def testCreateInvalidEmailUser(self):
        isUserCreatedWithBadEmail = self.model.createUser("rohit.lunavara@gmailco", "reset123")
        self.assertFalse(isUserCreatedWithBadEmail)

        isUserCreatedWithBadEmail = self.model.createUser("rohit.lunavaragmail.com", "reset123")
        self.assertFalse(isUserCreatedWithBadEmail)

        isUserCreatedWithBadEmail = self.model.createUser("@gmail.com", "reset123")
        self.assertFalse(isUserCreatedWithBadEmail)

        isUserCreatedWithBadEmail = self.model.createUser("rohit.com", "reset123")
        self.assertFalse(isUserCreatedWithBadEmail)

    def testCreateInvalidPasswordUser(self):
        isUserCreatedWithEmptyPassword = self.model.createUser("rohit.lunavara@gmail.com", "")
        self.assertFalse(isUserCreatedWithEmptyPassword)

        isUserCreatedWithOneCharacterPassword = self.model.createUser("rohit.lunavara@gmail.com", "t")
        self.assertFalse(isUserCreatedWithOneCharacterPassword)

        isUserCreatedWithFiveCharacterPassword = self.model.createUser("rohit.lunavara@gmail.com", "reset")
        self.assertFalse(isUserCreatedWithFiveCharacterPassword)

    def testVerifyCredentials(self):
        user = {
            "email": "rohit.lunavara@gmail.com",
            "password": "reset123"
        }
        isUserCreated = self.model.createUser(user["email"], user["password"])
        self.assertTrue(isUserCreated)

        isUserVerified = self.model.verifyCredentials(user["email"], user["password"])
        self.assertTrue(isUserVerified)

    def testVerifyInvalidCredentials(self):
        user = {
            "email": "rohit.lunavara@gmail.com",
            "password": "reset123"
        }
        isUserCreated = self.model.createUser(user["email"], user["password"])
        self.assertTrue(isUserCreated)

        isUserInvalidPasswordVerified = self.model.verifyCredentials(user["email"], user["password"] + "456")
        self.assertFalse(isUserInvalidPasswordVerified)

        isUserInvalidEmailVerified = self.model.verifyCredentials(user["email"] + "test", user["password"])
        self.assertFalse(isUserInvalidEmailVerified)

        isUserNoEmailVerified = self.model.verifyCredentials("", user["password"])
        self.assertFalse(isUserNoEmailVerified)


    def testCreateMessage(self):
        user = {
            "email": "rohit.lunavara@gmail.com",
            "password": "reset123"
        }
        isUserCreated = self.model.createUser(user["email"], user["password"])
        self.assertTrue(isUserCreated)

        messages = [
            "First Message",
            "Second Message"
        ]
        for message in messages:
            isMessageCreated = self.model.createMessage(user["email"], user["password"], message)
            self.assertTrue(isMessageCreated)

    def testInvalidUserCreateMessage(self):
        user = {
            "email": "rohit.lunavara@gmail.com",
            "password": "reset123"
        }
        isUserCreated = self.model.createUser(user["email"], user["password"])
        self.assertTrue(isUserCreated)

        invalidUser = {
            "email": "rohit.lunavara@gmail.com",
            "password": "reset123456"
        }
        messages = [
            "First Message",
            "Second Message"
        ]
        for message in messages:
            isMessageCreated = self.model.createMessage(invalidUser["email"], invalidUser["password"], message)
            self.assertFalse(isMessageCreated)

    def testGetMessagesSingleUser(self):
        user = {
            "email": "rohit.lunavara@gmail.com",
            "password": "reset123"
        }
        isUserCreated = self.model.createUser(user["email"], user["password"])
        self.assertTrue(isUserCreated)

        messages = [
            "First Message",
            "Second Message",
        ]
        for message in messages:
            isMessageCreated = self.model.createMessage(user["email"], user["password"], message)
            self.assertTrue(isMessageCreated)

        for message in self.model.getMessages(user["email"], user["password"]):
            self.assertTrue(message.message in messages)

    def testGetMessagesMultipleUsers(self):
        usersAndMessages = [
            {
                "email": "rohit.lunavara@gmail.com",
                "password": "reset123",
                "messages": [
                    "rohit.lunavara@gmail.com: First Message",
                    "rohit.lunavara@gmail.com: Second Message",
                ]
            },
            {
                "email": "rll2181@columbia.edu",
                "password": "reset123",
                "messages": [
                    "rll2181@columbia.edu: First Message",
                    "rll2181@columbia.edu: Second Message",
                ]
            }
        ]
        # Create users
        for user in usersAndMessages:
            isUserCreated = self.model.createUser(user["email"], user["password"])
            self.assertTrue(isUserCreated)

        # Create messages
        for user in usersAndMessages:
            for message in user["messages"]:
                isMessageCreated = self.model.createMessage(user["email"], user["password"], message)
                self.assertTrue(isMessageCreated)

        # Store all messages in a single list
        allMessages = []
        for user in usersAndMessages:
            allMessages.extend(user["messages"][:])

        # Get Messages
        for user in usersAndMessages:
            for message in self.model.getMessages(user["email"], user["password"]):
                self.assertTrue(message.message in allMessages)


if __name__ == '__main__':
    unittest.main()
