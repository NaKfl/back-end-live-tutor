import multer from 'multer';
import path from 'path';
import fs from 'fs';

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    const fieldname = file.fieldname;
    if (fieldname === 'avatar') {
      cb(null, path.join(__dirname, '../uploads/avatar'));
    } else if (fieldname === 'video') {
      cb(null, path.join(__dirname, '../uploads/video'));
    } else {
      cb(null, path.join(__dirname, '../uploads/temp'));
    }
  },
  filename: function (req, file, cb) {
    const user = req.user?.id;
    const typeImage = file.originalname.split('.')[1];
    fs.readdirSync(path.join(__dirname, `../uploads/${file.fieldname}`))
      .filter((file) => {
        const f = file.split('.');
        return f[0];
      })
      .forEach((existFile) => {
        if (existFile.split('.')[0] === `${user + file.fieldname}`) {
          fs.unlinkSync(
            path.join(__dirname, `../uploads/${file.fieldname}/${existFile}`),
          );
        }
      });
    const uniqueSuffix = '.' + typeImage;
    cb(null, user + file.fieldname + uniqueSuffix);
  },
});

const upload = multer({ storage: storage });

export default upload;
