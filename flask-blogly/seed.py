from models import User, connect_db, db
from app import app

connect_db(app)
#* create all tables
db.drop_all()
db.create_all()


#* if table isn't empty, empty it
User.query.delete()

#* Add pets 
mr = User(first_name ="Mr.", last_name="Rogers",image_url ="https://s3.us-east-2.amazonaws.com/inspire-kindness/posts/September2019/Jig6jU2g5Gg0v5yBmTAh.png")
will = User(first_name="Will", last_name="Smith",image_url ="https://thumbor.forbes.com/thumbor/fit-in/416x416/filters%3Aformat%28jpg%29/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5ed663d153104f0007d6f014%2F0x0.jpg%3Fbackground%3D000000%26cropX1%3D15%26cropX2%3D1047%26cropY1%3D48%26cropY2%3D1080")
rob = User(first_name="Rob", last_name="Zombie",image_url ="https://www.rollingstone.com/wp-content/uploads/2018/06/rob-zombie-a1543704-3d23-4cdb-879a-54a4f91a8b81.jpg?resize=1800,1200&w=1200")


db.session.add(mr)
db.session.add(will)
db.session.add(rob)

db.session.commit()