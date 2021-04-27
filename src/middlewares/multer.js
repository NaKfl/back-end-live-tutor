import multer from 'multer';
import path from 'path';
import fs from 'fs';

const dirUpload = path.join(__dirname, '../uploads');
const dirAvatar = path.join(__dirname, '../uploads/avatar');
const dirVideo = path.join(__dirname, '../uploads/video');
const dirTemp = path.join(__dirname, '../uploads/temp');

function ensureExists(path, mask, cb) {
  if (typeof mask == 'function') {
    // allow the `mask` parameter to be optional
    cb = mask;
    mask = 0o777;
  }
  fs.mkdir(path, mask, function (err) {
    if (err) {
      if (err.code == 'EEXIST') cb(null);
      else cb(err); // something else went wrong
    } else cb(null); // successfully created folder
  });
}
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    ensureExists(dirUpload, 0o744, function (err) {
      if (err) {
        console.log(err);
      }
    });
    const fieldname = file.fieldname;
    if (fieldname === 'avatar') {
      ensureExists(dirAvatar, 0o744, function (err) {
        if (err) {
          console.log(err);
        } else {
          cb(null, dirAvatar);
        }
      });
    } else if (fieldname === 'video') {
      ensureExists(dirVideo, 0o744, function (err) {
        if (err) {
          console.log(err);
        } else {
          cb(null, dirAvatar);
        }
      });
    } else {
      ensureExists(dirTemp, 0o744, function (err) {
        if (err) {
          console.log(err);
        } else {
          cb(null, dirTemp);
        }
      });
    }
  },
  filename: function (req, file, cb) {
    console.log(file);
    const user = req.user?.id;
    if (file.fieldname === 'avatar' || file.fieldname === 'video') {
      const typeImage = file.originalname.split('.')[1];
      const uniqueSuffix = '.' + typeImage;
      cb(null, user + file.fieldname + new Date().getTime() + uniqueSuffix);
    } else {
      cb(null, user + file.fieldname + file.originalname);
    }
  },
});

const upload = multer({ storage: storage });

export default upload;
