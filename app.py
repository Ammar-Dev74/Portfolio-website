from flask import Flask,redirect,request,render_template,request,url_for,Response
from flask.globals import session
from flask_sqlalchemy import SQLAlchemy
from flask import flash
from werkzeug.security import generate_password_hash,check_password_hash
from flask_login import login_user,login_manager,UserMixin,LoginManager,login_required,logout_user
import os 
from werkzeug.utils import secure_filename
from datetime import datetime
from flask import send_from_directory, abort
import pymysql
pymysql.install_as_MySQLdb()

local_server=True
app=Flask(__name__)
app.secret_key = os.environ.get("SECRET_KEY",
                               "development-secret")

db_user = os.environ.get("MYSQL_USER", "root")
db_password = os.environ.get("MYSQL_PASSWORD", "")
db_host = os.environ.get("MYSQL_HOST", "localhost")
db_name = os.environ.get("MYSQL_DB", "socialmedia")

app.config["SQLALCHEMY_DATABASE_URI"] = (
    f"mysql+pymysql://{db_user}:{db_password}@{db_host}/{db_name}"
)
db=SQLAlchemy(app)
login_manager= LoginManager(app)
login_manager.login_view="login"


#configuration for file handling
app.config['UPLOAD_FOLDER']='static/uploads/'
app.config['ALLOWED_EXTENSIONS']={'png','jpg','jpeg','gif'}
app.config['MAX_CONTENT_LENGTH']=16*1024*1024 #16MB upload size




@login_manager.user_loader
def load_user(user_id):
    return Signup.query.get(int(user_id))


class Test(db.Model):
     id=db.Column(db.Integer,primary_key=True)
     name=db.Column(db.String(50))
     
class Signup(UserMixin,db.Model):
    user_id=db.Column(db.Integer,primary_key=True)
    first_name=db.Column(db.String(50))
    last_name=db.Column(db.String(50))
    email=db.Column(db.String(100),unique=True)
    phone=db.Column(db.String(10),unique=True)
    password=db.Column(db.String(2000))
    
    def get_id(self):
        return self.user_id
    
class Post(db.Model):
     post_id=db.Column(db.Integer,primary_key=True)
     email=db.Column(db.String(50))
     name=db.Column(db.String(100))
     title=db.Column(db.String(100))
     description=db.Column(db.String(500))
     image=db.Column(db.String(500))
     date=db.Column(db.String)
     
class Contact(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    email = db.Column(db.String(100), nullable=False)
    subject = db.Column(db.String(255))
    message = db.Column(db.Text(500), nullable=False)
    created_at = db.Column(db.DateTime, default=db.func.now())

     
      
     
@app.route("/")
def index():
   
    return render_template("index.html") 

@app.route("/signup", methods=['GET','POST'])
def signup():
    if request.method == "POST":
        firstName = request.form.get("fname")
        lastName = request.form.get("lname")
        email = request.form.get("email")
        password = request.form.get("password")
        phoneNumber = request.form.get("phone")

        if not phoneNumber or len(phoneNumber) != 10:
            flash("Please enter a valid 10 digit phone number", "warning")
            return redirect(url_for("signup"))
        
        

        fetchemail = Signup.query.filter_by(email=email).first()
        fetchphone = Signup.query.filter_by(phone=phoneNumber).first()
        if fetchemail or fetchphone:
            flash("User already exists", "warning")
            return redirect(url_for("signup"))
        
        hashed_password = generate_password_hash(password)

        user = Signup(
        first_name=firstName,
        last_name=lastName,
        email=email,
        phone=phoneNumber,
        password=hashed_password,
        
            )

        db.session.add(user)
        db.session.commit()

        flash("Signup success", "success")
        return redirect(url_for("signup"))

    # ✅ THIS LINE WAS MISSING (VERY IMPORTANT)
    return render_template("signup.html")

     

@app.route("/login",methods=['GET','POST'])
def login():
    if request.method=="POST":
        email=request.form.get("email")
        password=request.form.get("password")
        
        user=Signup.query.filter_by(email=email).first()
        
        if user and check_password_hash(user.password,password):
            login_user(user)
            flash("login success","success")
            return render_template("index.html")
        else:
            flash("Invalid Credentials","info")
            return redirect(url_for("login"))
    return render_template("login.html")        



@app.route("/about")
def about():
    return render_template("about.html")

@app.route("/projects")
def portfolio():
    return render_template("projects.html")

@app.route("/learn")
def learn():
    return render_template("learn.html")



@app.route("/logout")
@login_required
def logout():
    logout_user()
    flash("Logout success","primary")
    return redirect(url_for('login'))
    
def allowed_file(filename):
    return'.'in filename and filename.rsplit('.',1)[1].lower() in  app.config['ALLOWED_EXTENSIONS']

@app.route("/post",methods=['GET','POST'])
@login_required
def post():
    data=Post.query.all()
    if request.method=="POST":
        email=request.form['email']
        name=request.form['name']
        title=request.form['title']
        description=request.form['description']
        file=request.files['image']
        date=datetime.now()
        date=date.date()
        
        if file and allowed_file(file.filename):
            #save file in upload folder
            filename=secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'],filename))
            
            #write query to save in db
            query=Post(email=email,name=name,title=title,description=description,image=filename,date=date)
            db.session.add(query)
            db.session.commit()
            flash("post is uploaded","info")
            return redirect(url_for('index'))
        else:
            flash("please use 'png','jpg','jpeg','gif' file format","warning")         
        
    return render_template("post.html",data=data)


DOWNLOAD_FOLDER = os.path.join(
    app.root_path,
    "static",
    "assets",
    "resume"
)

@app.route("/download/<filename>")
def downloadresume(filename):
    file_path = os.path.join(DOWNLOAD_FOLDER, filename)

    if not os.path.isfile(file_path):
        return f"File not found: {file_path}", 404

    return send_from_directory(
        DOWNLOAD_FOLDER,
        filename,
        as_attachment=True
    )


    
    
@app.route("/contact", methods=["GET", "POST"])
def contact():
    if request.method == "POST":

        # GET FORM DATA (REQUIRED)
        name = request.form.get("name") or ""
        email = request.form.get("email") or ""
        subject = request.form.get("subject") or ""
        message = request.form.get("message") or ""

        # SAVE TO FILE
        message_dir = os.path.join(app.root_path, "static", "messages")
        os.makedirs(message_dir, exist_ok=True)

        filename = f"contact_{datetime.now().strftime('%Y%m%d_%H%M%S%f')}.txt"
        with open(os.path.join(message_dir, filename), "w", encoding="utf-8") as f:
            f.write(message)

        # SAVE TO DATABASE
        contact = Contact(
            name=name,
            email=email,
            subject=subject,
            message=message
        )
        db.session.add(contact)
        db.session.commit()

        flash("Message sent successfully.", "success")

        # REDIRECT TO A REAL ROUTE
        return redirect(url_for("index"))  # <-- must exist

    return render_template("contact.html")

            
       


@app.route("/test")
def test():
    try:
        query=Test.query.all()
        print(query)
        return"database is connected"
    except:
        return"database is not connected"
