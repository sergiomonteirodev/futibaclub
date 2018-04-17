const express = require('express')
const app = express()
const mysql = require('mysql2/promise')
const account = require('./account')
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

app.use(account(connection))

app.listen(3000, err => console.log('Server is running in port 3000'))
}

init()



