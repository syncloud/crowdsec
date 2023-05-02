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

func CreateUser(username string) error {
	if !UserExists(username) {
		return createUser(username)
	}
	return nil
}

func createUser(username string) error {
	command := exec.Command("/usr/sbin/useradd",
		"-r",
		"-s", "/bin/false",
		"-m",
		"-d", fmt.Sprintf("/home/%s", username),
	)
	output, err := command.CombinedOutput()
	if err != nil {
		return fmt.Errorf("%w: %s", err, string(output))
	}
	return nil
}
