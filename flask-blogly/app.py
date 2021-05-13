"""Blogly application."""

from flask import Flask, request, render_template, redirect, flash, session
from flask_debugtoolbar import DebugToolbarExtension
from models import db, connect_db, User, Post, Tag, PostTag
import datetime


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql:///blogly'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SQLALCHEMY_ECHO'] = True

app.config['SECRET_KEY'] = "abc123"
app.config['DEBUG_TB_INTERCEPT_REDIRECTS'] = False
debug = DebugToolbarExtension(app)

connect_db(app)
db.create_all()

@app.route('/')
def direct_to_user_page():
    
    return redirect('/users') 
    

@app.route('/users')
def show_users(): 
    """
    show all users
    Make these links to view the detail page for the user
    Have a link here to the add-user form
    """
    users = User.query.all()
    
    return render_template('users.html', users=users)



@app.route('/users/new')

def add_user_page():
    """show an add form for users"""
    return render_template('new-user.html')

@app.route('/users/new', methods=["POST"])
def add_new_user():    
        """Process the add form, adding a new user and going back to /users"""
        first = request.form['first_name']
        last = request.form['last_name']
        image_url = request.form['image_url']
        new_user = User(first_name=first, last_name=last, image_url=image_url)
        db.session.add(new_user)
        db.session.commit()
        return redirect('/users')


@app.route('/users/<int:user_id>')
def edit_user(user_id):
   """Show info about selected User"""
   user = User.query.get_or_404(user_id)
   posts = user.posts
   return render_template('user-info.html', user=user, posts=posts)

@app.route('/users/<user_id>/edit', methods=["GET", "POST"])
def show_edit_user_form(user_id):
    #  """Show the edit page for the user
    #         Have a cancel button that returns to the detail page for a user, and a save button
    #         that updates the user
    #     """
        user = User.query.get(user_id)
        return render_template('edit-user.html', user=user)


@app.route('/users/<int:user_id>/edit', methods=["POST"])
def update_user(user_id):
    """Process the edit form, returning the user to the /users page"""
    user = User.query.get_or_404(user_id)
    user.first_name = request.form["first_name"]
    user.last_name = request.form["last_name"]
    user.image_url = request.form["image_url"]
    db.session.add(user)
    db.session.commit()
    return redirect('/users')

@app.route('/users/<int:user_id>/delete')
def delete_user(user_id):
    """Deletes a User"""
    user = User.query.get(user_id)
    db.session.delete(user)
    db.session.commit()
    return redirect('/users')

#******* Post Routes ********

@app.route('/posts/<post_id>')
def show_posts(post_id): 
    """Show post / Show buttons to edit and delete a post"""
    post = Post.query.get_or_404(post_id)
    
    return render_template('show-post.html', post=post)

@app.route('/users/<int:user_id>/posts/new')
def show_add_post_form(user_id): 
    """Show form to add post for user"""
    user = User.query.get(user_id)
    tags = Tag.query.all()
    return render_template('new-post-form.html', user=user, tags=tags)



@app.route('/users/<int:user_id>/posts/new', methods=["POST"])
def add_post_to_db(user_id): 
    """Handle add form / add post and redirect to user info page"""
    tag_ids= [int(num) for num in request.form.getlist("tags")]
    tags = Tag.query.filter(Tag.id.in_(tag_ids)).all()
    title = request.form['title']
    content = request.form['content']
    new_post = Post(title=title, content=content, user_id=user_id, tags=tags)
    
    db.session.add(new_post)
    db.session.commit()
    return redirect(f"/users/{user_id}")

@app.route('/posts/<post_id>/edit')
def show_edit_form(post_id):
    post = Post.query.get_or_404(post_id)
    tags = Tag.query.all()
    return render_template('edit-post.html', post=post, tags=tags)


@app.route('/posts/<post_id>/edit', methods=["POST"])
def edit_post(post_id):
    tag_ids= [int(num) for num in request.form.getlist("tags")]
    tags = Tag.query.filter(Tag.id.in_(tag_ids)).all()
    post =  Post.query.get_or_404(post_id)
    post.title = request.form['title']
    post.content = request.form['content']
    post.tags = tags
    db.session.add(post)
    db.session.commit()
    return redirect(f"/posts/{post_id}")

@app.route('/posts/<post_id>/delete')
def delete_post(post_id): 
    post = Post.query.get_or_404(post_id)
    db.session.delete(post)
    db.session.commit()
    return redirect(f"/users/{post.user_id}")

#***** Tags




@app.route('/tags')
def show_tags(): 
    """List all tags with links to tag detail page"""
    tags = Tag.query.all()
    return render_template('tags.html', tags=tags)

@app.route("/tags/<tag_id>")
def show_selected_tag(tag_id): 
    """Show tag detail with links to edit and delete"""
    tag = Tag.query.get_or_404(tag_id)
    
    return render_template('show-tag.html', tag=tag)

@app.route('/tags/new')
def show_new_tag_form():
    """display add new tag form"""
    return render_template('new-tag-form.html')

@app.route('/tags/new', methods=["POST"])
def edit_tag():
    """edit tag name"""
    tag_name= request.form['name']
    new_tag = Tag(name=tag_name)
    db.session.add(new_tag)
    db.session.commit()
    return redirect('/tags')

@app.route('/tags/<tag_id>/edit')
def show_tag_edit_form(tag_id):
    """"show edit form for a tag"""
    tag = Tag.query.get_or_404(tag_id)
    return render_template('edit-tag.html', tag=tag)

@app.route('/tags/<tag_id>/edit', methods=["POST"])
def edit_tag_name(tag_id): 
    """edit tag name and redirect back to 'tags'"""
    tag = Tag.query.get_or_404(tag_id)
    tag.name = request.form['name']
    db.session.add(tag)
    db.session.commit()
    return redirect('/tags')

@app.route('/tags/<tag_id>/delete')
def delete_tag(tag_id): 
    """delete tag"""
    tag = Tag.query.get_or_404(tag_id)
    db.session.delete(tag)
    db.session.commit()
    return redirect('/tags')
    
