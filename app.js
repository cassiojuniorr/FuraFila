const express = require('express');
const multer = require('multer');
const path = require('path');
const cors = require('cors');
const fs = require('fs');

const app = express();
app.use(cors());
app.use(express.json());

const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    const userId = req.body.userId;
    if (!userId) {
      return cb(new Error('O ID do usuário não foi fornecido'));
    }

    const userFolder = `./lib/imgCompany/${userId}`;
    if (!fs.existsSync(userFolder)) {
      fs.mkdirSync(userFolder, { recursive: true });
    }

    cb(null, userFolder);
  },
  filename: (req, file, cb) => {
    cb(null, Date.now() + path.extname(file.originalname))
  }
});


const upload = multer({ storage: storage });

app.post('/upload', upload.single('image'), (req, res) => {
  try {
    const userId = req.body.userId;
    if (!userId) {
      return res.status(400).send('O ID do usuário não foi fornecido');
    }
    res.send('Imagem enviada com sucesso!');
  } catch (error) {
    console.error('Erro ao processar o upload:', error);
    res.status(500).send('Erro interno do servidor.');
  }
});

app.listen(3000, () => {
  console.log('Servidor rodando na porta 3000');
});
