from app import app 

from app.controllers.users import users
from app.controllers.routes import routes
#from app.controllers.publications import publications
#from app.controllers.articles import articles 
#from app.controllers.messages import messages

app.register_blueprint(users)
app.register_blueprint(routes)
#app.register_blueprint(publications)
#app.register_blueprint(articles)
#app.register_blueprint(messages)



if __name__ == "__main__":
    app.run(debug=True)


# if __name__ == "__main__":
#     app.run(debug=True, host="0.0.0.0", port=8000)