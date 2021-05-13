from models import User, Post, PostTag, Tag, connect_db, db
from app import app

connect_db(app)
#* create all tables
db.drop_all()
db.create_all()


#* if table isn't empty, empty it
User.query.delete()

#* Add users 
mr = User(first_name ="Mr.", last_name="Rogers",image_url ="https://s3.us-east-2.amazonaws.com/inspire-kindness/posts/September2019/Jig6jU2g5Gg0v5yBmTAh.png")
will = User(first_name="Will", last_name="Smith",image_url ="https://thumbor.forbes.com/thumbor/fit-in/416x416/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5ed663d153104f0007d6f014%2F0x0.jpg%3Fbackground%3D000000%26cropX1%3D15%26cropX2%3D1047%26cropY1%3D48%26cropY2%3D1080")
rob = User(first_name="Rob", last_name="Zombie",image_url ="https://www.rollingstone.com/wp-content/uploads/2018/06/rob-zombie-a1543704-3d23-4cdb-879a-54a4f91a8b81.jpg?resize=1800,1200&w=1200")


db.session.add_all([mr, will, rob])

db.session.commit()

#* Add Posts
#title,content,user_id
p1 = Post(title="Forgiveness", content="Forgiveness is a strange thing. It can sometimes be easier to forgive our enemies than our friends. It can be hardest of all to forgive people we love. Like all of life's important coping skills, the ability to forgive and the capacity to let go of resentments most likely take root very early in our lives.",user_id=1)
p2 = Post(title="Quiet Moments", content="How many times have you noticed that it's the little quiet moments in the midst of life that seem to give the rest extra-special meaning?", user_id=1)
p3 = Post(title="Love", content="Love isn't a state of perfect caring. It is an active noun like struggle. To love someone is to strive to accept that person exactly the way he or she is, right here and now.", user_id=1)
p4 = Post(title="Fear", content="Fear is not real. It is a product of thoughts you create. Do not misunderstand me. Danger is very real. But fear is a choice", user_id=2)
p5 = Post(title="Talent", content="No matter how talented you are, your talent will fail you if you're not skilled. Skill is achieved through practice. Work hard and dedicate yourself to being better every single day.", user_id=2)
p6 = Post(title="Pampering", content="Great things come out of being hungry and cold. Once you're pampered, you get lazy.", user_id=3)
p7 = Post(title="White Zombie", content="White Zombie was a bunch of kids with the worst equipment playing in a basement. But that is what is so great about it. There is no reason to think you can't do it.", user_id=3)

db.session.add_all([p1,p2,p3,p4,p5,p6,p7])
db.session.commit()

#* Add Tags
t1 = Tag(name="funny")
t2 = Tag(name="family")
t3 = Tag(name="non-sequitur")

db.session.add_all([t1,t2,t3])
db.session.commit()

pt1 = PostTag(post_id=1, tag_id=2)
pt2 = PostTag(post_id=2, tag_id=2)
pt3 = PostTag(post_id=7, tag_id=3)
pt4 = PostTag(post_id=6, tag_id=1)

db.session.add_all([pt1, pt2, pt3])
db.session.commit()
