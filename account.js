const express = require('express')
const app = express.Router()

const init = connection => {

app.get('/', async(req, res) => {

	//const [rows, fields] = await connection.execute('select * from users')
	//console.log(rows)
	res.render('home')
})


app.get('/new-account', (req, res) =>{

	res.render('new-account', { error:false })
})


app.get('/login', (req, res) => {

	res.render('login', { error:false })
})

app.get('/logout', (req, res) => {
	req.session.destroy( err =>{
		res.redirect('/')
	})
})

app.post('/login', async(req, res) => {
	const [rows, fields] = await connection.execute('select * from users where email = ?', [req.body.email])
	if(rows.length === 0){

		res.render('login', { error: 'Usuario e/ou senha invalidos' })
	}else{

		if(rows[0].passwd === req.body.passwd){
			const userDb = rows[0]
			const user = {

				id: userDb.id,
				name: userDb.name,
				role: userDb.role

			}
			req.session.user = user
			res.redirect('/')

		}else{
			res.render('login', { error: 'Usuario e/ou senha invalidos' })
		}
	}

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
		
	} else {
		//console.log('Erro')
		res.render('new-account', {
			error: 'Usuario já existe'
		})
		
	}
	
})
return app

}

module.exports = init