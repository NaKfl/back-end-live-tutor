'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Transaction extends Model {
    static associate(models) {
      this.belongsTo(models.Wallet, {
        foreignKey: 'walletId',
        as: 'walletInfo',
      });
    }
  }
  Transaction.init(
    {
      id: {
        allowNull: false,
        primaryKey: true,
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        autoIncrement: false,
      },
      walletId: {
        type: DataTypes.UUID,
        allowNull: false,
        references: {
          model: 'Wallet',
          key: 'id',
        },
      },
      price: DataTypes.BIGINT,
      status: DataTypes.STRING,
      createdAt: { type: DataTypes.DATE, defaultValue: new Date() },
      updatedAt: { type: DataTypes.DATE, defaultValue: new Date() },
    },
    {
      sequelize,
      modelName: 'Transaction',
    },
  );
  return Transaction;
};
