const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = 3000;

// initial data
let events = initEvents();
let users = initUsers();
let tickets = initTickets();

app.use(cors());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get('/reset', async (req, res) => {
    console.log('reset');
    events = initEvents();
    users = initUsers();
    res.json({ message: 'reset' });
    // res.json({ message: 'users reset' });
    // res.json({ message: 'tickets reset' });

});


//Get method event by title, month, year
app.get('/event', async (req, res) => {
    if (req.query.title) {
        console.log("Tem query:"+req.query.title)
        const eventsTitle = events.filter(evt => evt.title === req.query.title)
        if(eventsTitle.length > 0){
            console.log("Achou a query")
            res.json(eventsTitle);
        }
        else{
            //res.status(404).send('Event not found'); //Removido para não dar erro de exceção
            res.json(eventsTitle);
        }   
    }
    else if (req.query.month && req.query.year) {
        console.log("Tem query: year=" + req.query.year + ", month=" + req.query.month)
        const eventsOfYearMonth = events.filter(evt => evt.month === req.query.month && evt.year === req.query.year)
        if(eventsOfYearMonth.length > 0){
            res.json(eventsOfYearMonth);
        }
        else{
            //res.status(404).send('Event not found'); //erro foi removido para não dar erro de exceção
            res.json(eventsOfYearMonth);
        }   
    }
    else if (req.query.title && req.query.month && req.query.year) {
        console.log("Tem query: title=" + req.query.title + "year=" + req.query.year + ", month=" + req.query.month)
        const eventsList = events.filter(evt => evt.title === req.query.title && evt.month === req.query.month && evt.year === req.query.year)
        if(eventsList.length > 0){
            res.json(eventsList);
        }
        else{
            res.status(404).send('Event not found');
        }   
    }
    else{
        console.log('get events');
        res.json(events);
    }
    
});


//Get method user by email, password
app.get('/user', async (req, res) => {
	
    if (req.query.email && req.query.password) {
        console.log("Tem query: email=" + req.query.email + ", password=" + req.query.password)
        const usersEmailPassword = users.filter(usr => usr.email === req.query.email && usr.password === req.query.password)
        if(usersEmailPassword.length > 0){
            res.json(usersEmailPassword);
        }
        else{
            res.status(404).send('User not found');
        }  
    }
    else if (req.query.email) {
        console.log("Tem query: email=" + req.query.email)
        const usersEmail= users.filter(usr => usr.email === req.query.email)
        if(usersEmail.length > 0){
            res.json(usersEmail);
        }
        else{
            res.status(404).send('User not found');
        }   
    }
    else{
        console.log('get users');
        res.json(users);
    }
    
});

//Get method ticket by email
app.get('/ticket', async (req, res) => {
	
    if (req.query.email) {
        console.log("Tem query: email=" + req.query.email)
        const ticketsEmail= tickets.filter(tkt => tkt.email === req.query.email)
        if(ticketsEmail.length > 0){
            res.json(ticketsEmail);
        }
        else{
            //res.status(404).send('Ticket not found');
            res.json(ticketsEmail);
        }   
    }
    else{
        console.log('get tickets');
        res.json(tickets);
    }
    
});

//Get method event by id
app.get('/event/:iid', async (req, res) => {
    const iid = parseInt(req.params.iid);
    console.log('get event ' + iid);
    for (b of events) {
        if (b.id === iid) {
            res.json(b);
            return;
        }
    }

    res.status(404).send('Event not found');
});

//Get method user by id
app.get('/user/:iid', async (req, res) => {
    const iid = parseInt(req.params.iid);
    console.log('get user ' + iid);
    for (b of users) {
        if (b.id === iid) {
            res.json(b);
            return;
        }
    }

    res.status(404).send('User not found');
});


//Get method event by id and title
app.get('/event/:iid/title', async (req, res) => {
    const iid = parseInt(req.params.iid);
    console.log(`get event ${iid} title`);
    bb = findEvent(events, iid);
    if (bb != null) {
        res.json(bb.title);
        return;
    }

    res.status(404).send('Event not found');
});

//Get method user by id and email
app.get('/user/:iid/email', async (req, res) => {
    const iid = parseInt(req.params.iid);
    console.log(`get user ${iid} email`);
    bb = findUser(users, iid);
    if (bb != null) {
        res.json(bb.email);
        return;
    }

    res.status(404).send('User not found');
});


//Update method event title
app.post('/event/:iid/title', async (req, res) => {
    const iid = parseInt(req.params.iid);
    console.log(`post title to event ${iid}`);
    bb = findEvent(events, iid);
    if (bb != null) {
        const tte = req.body;
        bb.messages.push(tte);
        res.json({ message: 'Title added to event ' + bb.title });
        return;
    }

    res.status(404).send('Event not found');
});


//Delete method event
app.delete('/event/:iid', async (req, res) => {
    const iid = parseInt(req.params.iid);
    console.log(`delete event ${iid}`);
    bb = findEvent(events, iid);
    if (bb != null) {
        events = events.filter(b => b.id != bb.id);
        res.json({ message: 'Event removed' });
        return;
    }

    res.status(404).send('Event not found');
});

//Delete method user
app.delete('/user/:iid', async (req, res) => {
    const iid = parseInt(req.params.iid);
    console.log(`delete user ${iid}`);
    bb = findUser(users, iid);
    if (bb != null) {
        users = users.filter(b => b.id != bb.id);
        res.json({ message: 'User removed' });
        return;
    }

    res.status(404).send('User not found');
});

//Delete method ticket
app.delete('/ticket/:iid', async (req, res) => {
    const iid = parseInt(req.params.iid);
    console.log(`delete ticket ${iid}`);
    bb = findTicket(tickets, iid);
    if (bb != null) {
        tickets = tickets.filter(b => b.id != bb.id);
        res.json({ message: 'Ticket removed' });
        return;
    }

    res.status(404).send('Ticket not found');
});

//Post method event
app.post('/event', async (req, res) => {
    const event = req.body;
    console.log("post event: " + event);
    event.id = events.length + 1;
    events.push(event);
    res.json(event);
});

//Post method user
app.post('/user', async (req, res) => {
    console.log("Request email:" + req.body.email);
    const usersTest = users.filter(b => b.email === req.body.email);
    console.log("Email:" + usersTest.email);
    if (usersTest.length > 0) {  
        console.log("Email already exists");
        res.status(409);
    }
    else{
        const user = req.body;
        console.log("post user: " + user);
        user.id = users.length + 1;
        users.push(user);
        res.json(user);
    }
    
});

//Post method ticket
app.post('/ticket', async (req, res) => {
    const ticket = req.body;
    console.log("post ticket: " + ticket);
    ticket.id = tickets.length + 1;
    tickets.push(ticket);
    res.json(ticket);
});


app.listen(port, () => {
    console.log('started server...');
});


//function to find a event
function findEvent(events, iid) {
    for (b of events) {
        if (b.id === iid) {
            return b;
        }
    }
    return null;
}

//function to find a user
function findUser(users, iid) {
    for (b of users) {
        if (b.id === iid) {
            return b;
        }
    }
    return null;
}

//function to find a ticket
function findTicket(tickets, iid) {
    for (b of tickets) {
        if (b.id === iid) {
            return b;
        }
    }
    return null;
}

//function to find a user by email
function findUserByEmail(users, email) {
    for (b of users) {
        if (b.email === email) {
            return b;
        }
    }
    return null;
}

//function to init events
function initEvents () {
    return [
        {
            id: 1,
            title: "Orquestra",
            day: "12",
            month: "12",
            year: "2023",
            hour: "15:00",
            local: "UFSCar",
            description: "na BCo",
            contact: "admin@gmail.com",
            contactname: "admin"
        },
        {
            id: 2,
            title: "Exposição",
            date: "20/12/2023",
            day: "20",
            month: "12",
            year: "2023",
            hour: "15:00",
            local: "UFSCar",
            description: "na BCo",
            contact: "admin@gmail.com",
            contactname: "admin"
        }
    ];
}

//function to init users
function initUsers () {
	return [
	    {
	    	id: 1,
	    	username: "Administrador",
	    	email: "admin@gmail.com",
	    	password: "admin"
	    },
	    {
	    	id: 2,
	    	username: "José da Silva",
	    	email: "jose@gmail.com",
	    	password: "jose123"
	    }
	]
}

//function to init tickets
function initTickets () {
	return [
            {
                id: 1,
	    		title: "Orquestra",
			    day: "12",
	    		month: "12",
	    		year: "2023",
	    		hour: "15:00",
                contact: "admin@admin.com",
	    		contactname: "Administrador",
            	email: "jose@gmail.com",
                username: "José da Silva"
            }
	]
}
