# =============================================================================
#
# Utility functions for zoxide.
#

# Default prompt for Nushell.
def __zoxide_prompt [] {
    let git = $"(do -i {git rev-parse --abbrev-ref HEAD} | str trim)"
    let git = (if (echo $git | str length) == 0 {
        ""
    } {
        build-string (char lparen) (ansi cb) $git (ansi reset) (char rparen)
    })
    build-string (ansi gb) (pwd) (ansi reset) $git "> "
}

# =============================================================================
#
# Hook configuration for zoxide.
#

# Hook to add new entries to the database.
def __zoxide_hook [] {
    shells | where active == $true && name == filesystem | get path | each { zoxide add -- $it }
}

# =============================================================================
#
# When using zoxide with --no-aliases, alias these internal functions as
# desired.
#

# Jump to a directory using only keywords.
def __zoxide_z [...rest:string] {
    if (shells | where active == $true | get name) != filesystem {
        if (echo $rest | length) > 1 {
            $"zoxide: can only jump directories on filesystem(char nl)"
        } {
            cd (echo $rest)
        }
    } {
        let arg0 = (echo $rest | append '~' | first 1);
        if (echo $rest | length) <= 1 && ($arg0 == '-' || (echo $arg0 | path expand | path exists)) {
            cd $arg0
        } {
            cd (zoxide query --exclude (pwd) -- $rest | str trim)
        }
    }
}

# Jump to a directory using interactive search.
def __zoxide_zi  [...rest:string] {
    if (shells | where active == $true | get name) != filesystem {
        $"zoxide: can only jump directories on filesystem(char nl)"
    } {
        cd (zoxide query -i -- $rest | str trim)
    }
}

# =============================================================================
#
# Convenient aliases for zoxide. Disable these using --no-aliases.
#

alias z = __zoxide_z
alias zi = __zoxide_zi

# =============================================================================
#
# To initialize zoxide, first create a Nushell script:
#
#   zoxide init nushell --hook prompt | save ~/.zoxide.nu
#
# Add this to your configuration (usually ~/.config/nu/config.toml):
#
#   prompt = "__zoxide_hook;__zoxide_prompt"
#   startup = ["zoxide init nushell --hook prompt | save ~/.zoxide.nu", "source ~/.zoxide.nu"]
#
# You can replace __zoxide_prompt with a custom prompt.
