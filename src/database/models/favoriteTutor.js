'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class FavoriteTutor extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      this.belongsTo(models.User, {
        foreignKey: 'secondId',
        as: 'secondInfo',
      });
      this.belongsTo(models.User, {
        foreignKey: 'firstId',
        as: 'firstInfo',
      });
      this.belongsTo(models.Tutor, {
        as: 'tutorInfo',
        foreignKey: 'secondId',
        targetKey: 'userId',
      });
    }
  }
  FavoriteTutor.init(
    {
      id: {
        allowNull: false,
        primaryKey: true,
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        autoIncrement: false,
      },
      firstId: DataTypes.UUID,
      secondId: DataTypes.UUID,
    },
    {
      sequelize,
      modelName: 'FavoriteTutor',
    },
  );
  return FavoriteTutor;
};
