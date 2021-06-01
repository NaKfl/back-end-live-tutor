'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Message extends Model {
    static associate(models) {
      this.belongsTo(models.User, {
        foreignKey: 'fromId',
        as: 'fromInfo',
      });
      this.belongsTo(models.User, {
        foreignKey: 'toId',
        as: 'toInfo',
      });
    }
  }
  Message.init(
    {
      id: {
        allowNull: false,
        primaryKey: true,
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        autoIncrement: false,
      },
      content: DataTypes.STRING,
      fromId: {
        type: DataTypes.UUID,
        allowNull: false,
        references: {
          model: 'User',
          key: 'id',
        },
      },
      toId: {
        type: DataTypes.UUID,
        allowNull: false,
        references: {
          model: 'User',
          key: 'id',
        },
      },
      isRead: { type: DataTypes.BOOLEAN, defaultValue: false },
      createdAt: DataTypes.DATE,
    },
    {
      sequelize,
      modelName: 'Message',
    },
  );
  return Message;
};
