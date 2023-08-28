const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
const port = 3000;

// initial data
let events = initEvents();

app.use(cors());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.get('/reset', async (req, res) => {
    console.log('reset');
    events = initEvents();
    res.json({ message: 'events reset' });
});

app.get('/event', async (req, res) => {
    console.log('get events');
    res.json(events);
});

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

app.post('/event/:iid/title', async (req, res) => {
    const iid = parseInt(req.params.iid);
    console.log(`post title to event ${iid}`);
    bb = findEvent(events, iid);
    if (bb != null) {
        const tte = req.body;
        bb.messages.push(tte);
        res.json({ message: 'Title added to event ' + bb.name });
        return;
    }

    res.status(404).send('Event not found');
});

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

app.post('/event', async (req, res) => {
    const event = req.body;
    console.log("post event: " + event);
    event.id = events.length + 1;
    events.push(event);
    res.json(event);
});

app.listen(port, () => {
    console.log('started server...');
});

function findEvent(events, iid) {
    for (b of events) {
        if (b.id === iid) {
            return b;
        }
    }
    return null;
}

function initEvents () {
    return [
        {
            id: 1,
            name: 'event_test1',
            title: "Orquestra",
            date: "12/12/2023",
            hour: "15:00",
            location: "UFSCar",
            description: "na BCo",
            contact: "admin@gmail.com",
            contactname: "admin"
        },
        {
            id: 2,
            name: 'event_test2',
            title: "Exposição",
            date: "20/12/2023",
            hour: "15:00",
            location: "UFSCar",
            description: "na BCo",
            contact: "admin@gmail.com",
            contactname: "admin"
        }
    ];
}
