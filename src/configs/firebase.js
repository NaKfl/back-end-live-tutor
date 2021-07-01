import admin from 'firebase-admin';

import { googleCredential } from 'configs/vars';

const serviceAccount = require(googleCredential.firebase);

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

export const messaging = admin.messaging();
