'use strict';
import bcrypt from 'bcryptjs';
const { Model, Op } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class student extends Model {
    /**
     * Helper method for defining associations.
     * This method is not a part of Sequelize lifecycle.
     * The `models/index` file will call this method automatically.
     */
    static associate(models) {
      // define association here
    }
  }
  student.init(
    {
      email: DataTypes.STRING,
      password: DataTypes.STRING,
      avatar: DataTypes.STRING,
      name: DataTypes.STRING,
      country: DataTypes.STRING,
      phone: DataTypes.STRING,
      gender: DataTypes.STRING,
      isDeleted: { type: DataTypes.BOOLEAN, defaultValue: false },
    },
    {
      sequelize,
      modelName: 'student',
    },
  );

  student.addHook('beforeSave', async function (user) {
    if (user.changed('password')) {
      user.password = await bcrypt.hash(user.password, 12);
    }
  });

  student.isEmailTaken = async function (email, excludeUserId) {
    const user = await this.findOne({
      where: {
        [Op.and]: [
          { email },
          {
            id: {
              [Op.ne]: excludeUserId,
            },
          },
        ],
      },
    });
    return !!user;
  };
  student.prototype.isPasswordMatch = async function (password) {
    return bcrypt.compare(password, this.password);
  };

  student.prototype.transform = function () {
    const transformed = {};
    const fields = [
      'id',
      'email',
      'name',
      'avatar',
      'country',
      'gender',
      'phone',
    ];
    fields.forEach((field) => {
      transformed[field] = this[field];
    });
    return transformed;
  };

  return student;
};
