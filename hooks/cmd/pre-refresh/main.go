package main

import (
	"fmt"
	"github.com/spf13/cobra"
	"hooks"
	"os"
)

func main() {
	var rootCmd = &cobra.Command{
		SilenceUsage: true,
		RunE: func(cmd *cobra.Command, args []string) error {
			return hooks.New().PreRefresh()
		},
	}

	err := rootCmd.Execute()
	if err != nil {
		fmt.Print(err)
		os.Exit(1)
	}
}
