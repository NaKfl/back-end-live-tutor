module.exports = {
  apps: [
    {
      name: 'live-tutor-server',
      script: './build/index.js',
      watch: true,
      ignore_watch: ['node_modules', 'build'],
      instances: 4,
      env: {
        NODE_ENV: 'development',
      },
    },
  ],
};
