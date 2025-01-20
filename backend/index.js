const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
const bcrypt = require('bcrypt');
require('dotenv').config();

const app = express();

app.use(cors());
app.use(express.json());

// MySQL bağlantısı
const db = mysql.createConnection({
  host: 'localhost',
  user: 'sahin',
  password: 'root',
  database: 'tour_program'
});

// Veritabanı bağlantısını kontrol et
db.connect((err) => {
  if (err) {
    console.error('Database connection failed:', err);
  } else {
    console.log('Connected to database');
  }
});

// Routes
const authRoutes = require('./routes/auth')(db);
const companyRoutes = require('./routes/company')(db);
const agencyRoutes = require('./routes/agency')(db);
const agencyAddCompanies = require('./routes/agencyAddCompanies')(db);
const backupRoutes = require('./routes/backup')(db);
const tourlist = require('./routes/tourlist')(db);

// Route middlewares
app.use('/auth', authRoutes);
app.use('/company', companyRoutes);
app.use('/agency', agencyRoutes);
app.use('/agencyAddCompanies', agencyAddCompanies);
app.use('/tourlist', tourlist);

app.use('/backup', backupRoutes);

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
}); 