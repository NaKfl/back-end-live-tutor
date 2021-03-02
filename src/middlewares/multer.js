import multer from 'multer';
import path from 'path';

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, path.join(__dirname, '../uploads/'));
  },
  filename: function (req, file, cb) {
    const user = req.user?.id;
    const typeImage = file.originalname.split('.')[1];
    const uniqueSuffix = '.' + typeImage;
    cb(null, user + '-avatar' + uniqueSuffix);
  },
});

const upload = multer({ storage: storage });

export default upload;
