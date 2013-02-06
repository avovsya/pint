express = require 'express'
http = require 'http'
path = require 'path'

app = express()

devHandlers = (app) ->
    app.use express.static(path.join(__dirname, 'public/test'))
    app.get '/test/coverage', (req, res) ->
        res.send 'Here would be coverage report'

    app.get '/test', (req, res) ->
        res.sendfile path.resolve('public/test/index.html')


app.configure ->
    app.set 'port', process.env.PORT or 3000
    app.use express.logger('dev')
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use app.router
    app.use express.static(path.join(__dirname, 'public/app'))

app.configure 'development', ->
    app.use express.errorHandler()
    devHandlers app

app.configure 'test', ->
    app.use express.errorHandler()
    devHandlers app

# routes
app.get '/', (req, res) ->
    res.sendfile path.resolve('public/app/index.html')

http.createServer(app).listen app.get('port'), ->
    console.log "Server listening on port #{app.get('port')}"
