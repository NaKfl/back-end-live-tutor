module.exports = {
  apps: [
    {
      name: 'live-tutor-server',
      script: './build/index.js',
      watch: false,
      instances: 2,
      exec_mode: 'cluster',
      env: {
        NODE_ENV: 'development',
      },
    },
  ],
};
