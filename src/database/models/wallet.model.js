'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Wallet extends Model {
    static associate(models) {
      this.belongsTo(models.User, {
        foreignKey: 'userId',
        as: 'userInfo',
      });
      this.hasMany(models.Transaction, {
        foreignKey: 'walletId',
        as: 'walletInfo',
      });
    }
  }
  Wallet.init(
    {
      id: {
        allowNull: false,
        primaryKey: true,
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        autoIncrement: false,
      },
      userId: {
        type: DataTypes.UUID,
        allowNull: false,
        references: {
          model: 'User',
          key: 'id',
        },
      },
      amount: DataTypes.BIGINT,
      isBlocked: DataTypes.BOOLEAN,
      createdAt: { type: DataTypes.DATE, defaultValue: new Date() },
      updatedAt: { type: DataTypes.DATE, defaultValue: new Date() },
    },
    {
      sequelize,
      modelName: 'Wallet',
    },
  );
  return Wallet;
};
