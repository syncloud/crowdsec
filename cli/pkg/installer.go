package pkg

import (
	"fmt"
	cp "github.com/otiai10/copy"
	"os"
	"os/exec"
	"path"
)

const (
	App       = "crowdsec"
	AppDir    = "/snap/crowdsec/current"
	DataDir   = "/var/snap/crowdsec/current"
	CommonDir = "/var/snap/crowdsec/common"
)

type Installer struct {
	NewVersionFile     string
	CurrentVersionFile string
}

func New() *Installer {
	return &Installer{
		NewVersionFile:     path.Join(AppDir, "version"),
		CurrentVersionFile: path.Join(DataDir, "version"),
	}
}

func (i *Installer) Install() error {
	err := CreateUser(App)
	if err != nil {
		return err
	}
	err = AddUserToGroup(App, "systemd-journal")
	if err != nil {
		return err
	}

	err = i.UpdateConfigs()
	if err != nil {
		return err
	}
	err = cp.Copy(path.Join(AppDir, "metabase/metabase.db"), path.Join(DataDir))
	if err != nil {
		return err
	}
	err = cp.Copy(path.Join(AppDir, "crowdsec/staging/var/lib/crowdsec/data"), path.Join(DataDir, "data"))
	if err != nil {
		return err
	}

	err = os.Mkdir(path.Join(CommonDir, "nginx"), 0755)
	if err != nil {
		return err
	}
	err = os.Mkdir(path.Join(CommonDir, "log"), 0755)
	if err != nil {
		return err
	}
	command := exec.Command("snap",
		"run",
		"crowdsec.cscli",
		"-c", path.Join(DataDir, "config/crowdsec/config.yaml"),
		"machines", "add", "-a",
	)
	output, err := command.CombinedOutput()
	if err != nil {
		return fmt.Errorf("%w: %s", err, string(output))
	}

	err = i.FixPermissions()
	if err != nil {
		return err
	}
	return nil
}

func (i *Installer) Configure() error {
	return i.UpdateVersion()
}

func (i *Installer) PreRefresh() error {
	return nil
}

func (i *Installer) PostRefresh() error {
	err := i.UpdateConfigs()
	if err != nil {
		return err
	}

	err = i.ClearVersion()
	if err != nil {
		return err
	}

	err = i.FixPermissions()
	if err != nil {
		return err
	}
	return nil

}

func (i *Installer) ClearVersion() error {
	return os.RemoveAll(i.CurrentVersionFile)
}

func (i *Installer) UpdateVersion() error {
	return cp.Copy(i.NewVersionFile, i.CurrentVersionFile)
}

func (i *Installer) UpdateConfigs() error {
	return cp.Copy(path.Join(AppDir, "config"), path.Join(DataDir, "config"))
}

func (i *Installer) FixPermissions() error {
	err := Chown(DataDir, App)
	if err != nil {
		return err
	}
	err = Chown(CommonDir, App)
	if err != nil {
		return err
	}
	return nil
}
