const express = require('express')
const app = express()
const mysql = require('mysql2/promise')
const account = require('./account')
const admin = require('./admin')
const bodyParser = require('body-parser')
const session = require('express-session')

app.use(session({

	secret: 'teste-secret',
	resave: true,
	saveUninitialized: true

}))
app.use(express.static('public'))
app.use(bodyParser.urlencoded({ extended: true }))



app.set('view engine', 'ejs')

const init = async() => {
const connection = await mysql.createConnection({

	host:'127.0.0.1',
	user:'root',
	password:'123',
	database:'futibaclub'


})

app.use((req, res, next) => {

	if(req.session.user){

		res.locals.user = req.session.user
	}else{

		res.locals.user = false
	}
	next()
})

app.use(account(connection))

app.use('/admin', admin(connection))

app.listen(3000, err => console.log('Servidor rodando na porta 3000'))
}

init()



