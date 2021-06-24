module.exports = {
  apps: [
    {
      name: 'live-tutor-server',
      script: './build/index.js',
      watch: false,
      instances: 3,
      exec_mode: 'cluster',
      autorestart: true,
      env: {
        NODE_ENV: 'production',
      },
    },
  ],
};
