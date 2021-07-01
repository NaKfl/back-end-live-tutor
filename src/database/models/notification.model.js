'use strict';

const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Notification extends Model {
    // static associate(models) {}
  }

  Notification.init(
    {
      token: {
        type: DataTypes.TEXT,
        allowNull: false,
        primaryKey: true,
      },
      createdAt: DataTypes.DATE,
      updatedAt: DataTypes.DATE,
    },
    {
      sequelize,
      modelName: 'Notification',
    },
  );

  return Notification;
};
