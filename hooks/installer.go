package hooks


type Installer struct {
}

func New() *Installer {
	return &Installer{}
}

func (i *Installer) Install() error {
	return nil
}

func (i *Installer) Configure() error {
	return nil
}

func (i *Installer) PreRefresh() error {
	return nil
}

func (i *Installer) PostRefresh() error {
	return nil
}
