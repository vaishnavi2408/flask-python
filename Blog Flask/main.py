from flask import Flask, render_template, request, session, redirect
from flask_sqlalchemy import SQLAlchemy
from werkzeug import secure_filename
# from flask_mail import Mail
from datetime import datetime
import json
import os
import math

with open('config.json', 'r') as c:
    params = json.load(c) ["params"]

app = Flask(__name__)
app.secret_key = 'super-secret-key'
app.config['UPLOAD_FOLDER']=params["upload_location"]
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params['gmail_user'],
    MAIL_PASSWORD=params['gmail_password']
)
# mail=Mail(app)
local_server = params['local_server']
if(local_server):
    app.config['SQLALCHEMY_DATABASE_URI'] = params["local_uri"]
else:
    app.config['SQLALCHEMY_DATABASE_URI'] = params["prod_uri"]

db = SQLAlchemy(app)

class Contacts(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), nullable=False)
    email = db.Column(db.String(120), unique=True, nullable=False)
    ph_num = db.Column(db.String(10))
    msg = db.Column(db.String(120), nullable=False)

class Posts(db.Model):
    post_id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    slug = db.Column(db.String(25), unique=True, nullable=False)
    content = db.Column(db.String(120), nullable=False)
    tagline = db.Column(db.String(120), nullable=False)
    img_file = db.Column(db.String(120), nullable=False)
    date = db.Column(db.String(12), nullable=True)

@app.route("/")
def home():
    posts = Posts.query.filter_by().all()
    # [0:params["no_of_posts"]]
    last=math.ceil(len(posts)/int(params["no_of_posts"]))
    page=request.args.get('page') #GET parameter
    # Pagination logic
    if(not str(page).isnumeric()):
        page = 1
    page=int(page)
    posts=posts[(page-1)*int(params["no_of_posts"]) : (page-1)*int(params["no_of_posts"])+int(params["no_of_posts"])]
    # first page
    if(page==1):
        prev="#" # prev blank
        next="/?page="+(str(page+1)) # next=page+1
    # last page
    elif(page>=last):
        prev="/?page="+(str(page-1)) # prev=page-1
        next="#" # next blank
    # middle page
    else:
        prev="/?page="+(str(page-1)) # prev=page-1
        next="/?page="+(str(page+1)) # next=page+1
    return render_template('index.html',params=params,posts=posts,prev=prev,next=next)

@app.route("/uploader", methods=['GET', 'POST'])
def uploader():
    if 'username' in session and session['username'] == params['admin_username'] :
        if request.method=='POST':
            f=request.files['file1']
            f.save(os.path.join(app.config['UPLOAD_FOLDER'],secure_filename(f.filename)))
            return "Uploaded successfully!"

@app.route("/about")
def about():
    return render_template('about.html',params=params)

@app.route("/logout")
def logout():
    session.pop('username')
    return redirect('/dashboard')

@app.route("/contact", methods=['GET', 'POST'])
def contact():
    if(request.method == 'POST'):
        name = request.form.get('name')
        email = request.form.get('email')
        phone = request.form.get('phone')
        msg = request.form.get('msg')

        entry = Contacts(name=name, email=email, ph_num=phone, msg=msg)
        db.session.add(entry)
        db.session.commit()
        # mail.send_message(title='new message from '+name, sender=email, recipients=[params['gmail_user']], body=msg +'\n'+phone)

    return render_template('contact.html',params=params)

@app.route("/post/<string:post_slug>", methods=['GET'])
def post_route(post_slug):
    post = Posts.query.filter_by(slug=post_slug).first()
    return render_template('post.html',params=params,post=post)

@app.route("/delete/<string:post_id>", methods=['GET'])
def Delete(post_id):
    if('username' in session and session['username'] == params['admin_username']):
        post=Posts.query.filter_by(post_id=post_id).first()
        db.session.delete(post)
        db.session.commit()
    return redirect('/dashboard')


@app.route('/dashboard', methods=['GET','POST'])
def dashboard():
    if('username' in session and session['username'] == params['admin_username']):
        posts=Posts.query.all()
        return render_template('dashboard.html', params=params, posts=posts)

    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        if(username == params["admin_username"] and password == params["admin_password"]):
            # set the session variable
            session['username'] = username
            posts = Posts.query.all()
            return render_template('dashboard.html', params=params, posts=posts)

    return render_template('login.html',params=params)

@app.route('/edit/<string:post_id>', methods=['GET','POST'])
def edit(post_id):
    if 'username' in session and session['username'] == params['admin_username']:
        if request.method=='POST':
            title = request.form.get('title')
            tagline = request.form.get('tagline')
            slug = request.form.get('slug')
            content = request.form.get('content')
            img = request.form.get('img_file')
            date=datetime.now()

            if post_id == '0':
                post=Posts(title=title, slug=slug, content=content, tagline=tagline,date=date, img_file=img)
                db.session.add(post)
                db.session.commit()
            else:
                post = Posts.query.filter_by(post_id=post_id).first()
                post.title = title
                post.tagline = tagline
                post.slug = slug
                post.content = content
                post.img_file = img
                db.session.commit()
                return redirect('/edit/'+post_id)
    post=Posts.query.filter_by(post_id=post_id).first()
    return render_template('edit.html', params=params, post=post, post_id=post_id)

app.run(debug=True)