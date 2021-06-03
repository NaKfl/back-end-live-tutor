'use strict';

const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Category extends Model {
    static associate(models) {
      this.belongsTo(models.Type, {
        foreignKey: 'typeId',
        as: 'type',
      });
    }
  }

  Category.init(
    {
      id: {
        allowNull: false,
        primaryKey: true,
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        autoIncrement: false,
      },
      typeId: {
        allowNull: false,
        type: DataTypes.UUID,
        references: {
          model: 'Type',
          key: 'id',
        },
      },
      description: {
        allowNull: false,
        type: DataTypes.STRING,
      },
    },
    {
      sequelize,
      modelName: 'Category',
    },
  );

  return Category;
};
