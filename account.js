const express = require('express')
const app = express.Router()

const init = connection => {

app.get('/', async(req, res) => {

	const [rows, fields] = await connection.execute('select * from users')
	console.log(rows)
	res.render('home')
})
app.get('/new-account', (req, res) =>{

	res.render('new-account', {error:false })
})

app.post('/new-account', async(req, res) => {

	const [rows, fields] = await connection.execute('select * from users where email = ?', [req.body.email])

	if(rows.length === 0){
		const {name, email, passwd} = req.body

	await connection.execute('insert into users (name, email, passwd, role) values (?,?,?,?)', [

		name,
		email,
		passwd,
		'user'
	])

	res.redirect('/')
		
	}else{
		console.log('Erro')
		res.render('new-account', {
			error: 'Usuario já existe'
		})
		
	}
	
})
return app

}

module.exports = init