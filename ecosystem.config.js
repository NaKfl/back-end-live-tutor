module.exports = {
  apps: [
    {
      name: 'live-tutor-server',
      script: './build/index.js',
      watch: true,
      env: {
        NODE_ENV: 'development',
      },
    },
  ],
};
