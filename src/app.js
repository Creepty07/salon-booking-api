import express from "express";

/* import clientsRoutes from './routes/clients.routes.js';
import appointmentsRoutes from './routes/appointments.routes.js';
import servicesRoutes from './routes/services.routes.js';
import errorHandler from './middlewares/errorHandler.js'; */

const app = express();


// Middlewares
app.use(express.json())

/*
// Routes
app.use('/clients', clientsRoutes);
app.use('/appointments', appointmentsRoutes);
app.use('/services', servicesRoutes); */

app.get('/health', (req, res) => {
    res.status(200).json({
        status: "ok"
    })
})

// Error Handler
// app.use(errorHandler)

export default app;