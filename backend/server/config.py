class Config:
    DATABASE_URI = "postgresql://postgres:password@postgres/ChatApplication"


class TestConfig:
    DATABASE_URI = "sqlite:///ChatApplicationTest.sqlite3"


class DevelopmentConfig(Config):
    DATABASE_URI = "postgresql://localhost:5432/ChatApplicationDev"


config = {
    "production": Config,
    "test": TestConfig,
    "development": DevelopmentConfig,

    # Change to what you need in production
    "current": Config
}
