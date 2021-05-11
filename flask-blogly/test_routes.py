from unittest import TestCase
from urllib import response

from app import app
from models import db, User

# Use test database and don't clutter tests with SQL
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql:///user_test'
app.config['SQLALCHEMY_ECHO'] = False

# Make Flask errors be real errors, rather than HTML pages with error info
app.config['TESTING'] = True

# This is a bit of hack, but don't use Flask DebugToolbar
app.config['DEBUG_TB_HOSTS'] = ['dont-show-debug-toolbar']

db.drop_all()
db.create_all()

class UserTests(TestCase):
    
    def setUp(self): 
        
        User.query.delete()
        user = User(first_name="Micheal", last_name="Scott", image_url="https://img1.looper.com/img/gallery/the-offices-michael-scott-was-almost-a-murderer/intro-1591207215.jpg")
        db.session.add(user)
        db.session.commit()

        self.user_id = user.id
        self.user = user
    def tearDown(self):
        
        db.session.rollback()
    
    def test_user_list(self):
        with app.test_client() as client: 
            resp = client.get('/users')
            html = resp.get_data(as_text=True)

            self.assertEqual(resp.status_code, 200)
            self.assertIn('Micheal', html)

    def test_user_info_page(self):
        with app.test_client() as client: 
            resp = client.get(f"/users/{self.user_id}")
            html = resp.get_data(as_text=True)

            self.assertEqual(resp.status_code, 200)
            self.assertIn("Micheal Scott", html)

    def test_user_edit_page(self):
        with app.test_client() as client: 
            resp = client.get(f"/users/{self.user_id}/edit")
            html = resp.get_data(as_text=True)

            self.assertEqual(resp.status_code, 200)
            self.assertIn('<button type="submit" class="btn btn-success">Save</button>', html)

    def test_new_user_addition(self):
        with app.test_client() as client: 
            user_info = {"first_name":"Elvis", "last_name":"Presley", "image_url":"https://upload.wikimedia.org/wikipedia/commons/thumb/9/99/Elvis_Presley_promoting_Jailhouse_Rock.jpg/330px-Elvis_Presley_promoting_Jailhouse_Rock.jpg"}
            resp = client.post('/users/new', data=user_info, follow_redirects=True)
            html = resp.get_data(as_text=True)

            self.assertEqual(resp.status_code, 200)
            self.assertIn("Elvis Presley", html)
