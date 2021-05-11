"""Models for Blogly."""
from flask_sqlalchemy import SQLAlchemy


db = SQLAlchemy()
def connect_db (app):
    db.app = app
    db.init_app(app)

class User(db.Model):
    __tablename__ = 'users'

    @classmethod
    def update_user(self, user):
        self.first_name = user.first_name
        self.last_name = user.last_name
        self.image_url = user.image_url
        db.session.add(self)
        db.session.commit()

    id = db.Column(db.Integer, 
                primary_key=True, 
                autoincrement=True)
    first_name = db.Column(db.String(20),
                            nullable=False)
    last_name = db.Column(db.String(20),
                            nullable=False)
    image_url = db.Column(db.String, 
                            nullable=True)
