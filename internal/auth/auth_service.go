package auth

import (
	"errors"
	"smarttransit-backend/pkg/utils"

	"golang.org/x/crypto/bcrypt"
)

func RegisterUser(request RegisterRequest) error {

	hashedPassword, err := bcrypt.GenerateFromPassword(
		[]byte(request.Password),
		bcrypt.DefaultCost,
	)

	if err != nil {
		return err
	}

	return CreateUser(request, string(hashedPassword))
}

func LoginUser(request LoginRequest) (string, error) {

	user, err := GetUserByEmail(request.Email)

	if err != nil {
		return "", errors.New("invalid email or password")
	}

	err = bcrypt.CompareHashAndPassword(
		[]byte(user.Password),
		[]byte(request.Password),
	)

	if err != nil {
		return "", errors.New("invalid email or password")
	}

	token, err := utils.GenerateToken(user.ID)

	if err != nil {
		return "", err
	}

	return token, nil
}
