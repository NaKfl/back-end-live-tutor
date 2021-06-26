module.exports = {
  apps: [
    {
      name: 'live-tutor-server',
      script: './build/index.js',
      watch: false,
      instances: 'max',
      exec_mode: 'cluster',
      autorestart: true,
      env: {
        NODE_ENV: 'production',
      },
    },
  ],
};
