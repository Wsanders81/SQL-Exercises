
from unittest import TestCase
from urllib import response

from app import app
from models import db, User, Post


# Use test database and don't clutter tests with SQL
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql:///user_test'
app.config['SQLALCHEMY_ECHO'] = False

# Make Flask errors be real errors, rather than HTML pages with error info
app.config['TESTING'] = True

# This is a bit of hack, but don't use Flask DebugToolbar
app.config['DEBUG_TB_HOSTS'] = ['dont-show-debug-toolbar']

# db.drop_all()
# db.create_all()

class UserTests(TestCase):
    
    def setUp(self): 
        db.create_all()
        User.query.delete()
        Post.query.delete()
        user = User(first_name="Micheal", last_name="Scott", image_url="https://img1.looper.com/img/gallery/the-offices-michael-scott-was-almost-a-murderer/intro-1591207215.jpg")
        db.session.add(user)
        db.session.commit()

        self.user_id = user.id
        self.user = user
        post = Post(title="who i am", content="I am Beyonce, always", user_id=self.user_id)
        db.session.add(post)
        db.session.commit()

        self.post_id = post.id 
        self.post = post

        
    def tearDown(self):
        db.session.rollback()
        db.drop_all()
    
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

    def test_new_post(self): 
        with app.test_client() as client: 
            post = {'title':'Who I Am', 'content': 'I am Beyonce, always.', "user_id":self.user_id}
            resp = client.post(f"/users/{self.user_id}/posts/new", data=post, follow_redirects=True)
            html = resp.get_data(as_text=True)

            self.assertEqual(resp.status_code, 200)
            self.assertIn('<li> <a href="/posts/1">who i am</a> </li>', html)

    def test_post_removal(self): 
        with app.test_client() as client: 
            resp = client.post(f"/posts/{self.post_id}/delete")
            html = resp.get_data(as_text=True)
            self.assertNotIn("who i am", html)


