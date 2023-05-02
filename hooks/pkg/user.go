package pkg

import (
	"fmt"
	"os/exec"
	"os/user"
)

func UserExists(username string) bool {
	_, err := user.Lookup(username)
	return err == nil
}

func UserCreateIfMissing(username string) error {
	if !UserExists(username) {
		UserCreate(username)
	}
}

func UserCreate(username string) ([]byte, error) {
	command := exec.Command("/usr/sbin/useradd",
		"-r",
		"-s", "/bin/false",
		"-m",
		"-d", fmt.Sprintf("/home/%s", username),
	)
	return command.CombinedOutput()
}
