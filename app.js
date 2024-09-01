const express = require('express');
const multer = require('multer');
const path = require('path');
const cors = require('cors')

const app = express();
const fs = require('fs');
app.use(cors());


const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const uploadPath = './lib/imgCompany/';
    if (!fs.existsSync(uploadPath)) {
      fs.mkdirSync(uploadPath, { recursive: true });
    }
    cb(null, uploadPath);
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname));
  }
});

const upload = multer({ storage: storage });

app.post('/upload', upload.single('image'), (req, res) => {
  try {
    res.send('Imagem enviada com sucesso!');
  } catch (error) {
    console.error('Erro ao processar o upload:', error);
    res.status(500).send('Erro interno do servidor.');
  }
});


app.listen(3000, () => {
  console.log('Servidor rodando na porta 3000');
});
