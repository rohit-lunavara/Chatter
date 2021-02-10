from config import config
import logging
from sqlalchemy import create_engine, Integer, Column, String, Text, ForeignKey
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker, relationship, backref
from sqlalchemy_utils import create_database, database_exists

Base = declarative_base()


class User(Base):
    __tablename__ = "users"

    email = Column(String, primary_key=True)
    password = Column(String)
    messages = relationship("Message", backref=backref("user", lazy="noload"))

    def __repr__(self):
        return f"<User {self.email}>"


class Message(Base):
    __tablename__ = "messages"

    id = Column(Integer, primary_key=True)
    message = Column(Text)
    email = Column(String, ForeignKey("users.email"))

    def __init__(self, message):
        self.message = message

    def __repr__(self):
        return f"<Message {self.id} {self.message}>"


def createDatabase(config):
    databaseEngine = create_engine(config.DATABASE_URI)
    if not database_exists(databaseEngine.url):
        create_database(databaseEngine.url)
    Base.metadata.create_all(databaseEngine)


# TODO - Change config in deployment
createDatabase(config["current"])
