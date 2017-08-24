function Power-Horse {

param (

[switch] $survey,
[switch] $hashdir,
[switch] $help)

# This switch will gather information about the host it is executed on
# and write the results to a file

if ($survey) {
    #checks if survey.txt file exists in C:\documents folder
    $Condition=Test-Path C:\documents\survey.txt
    # if survey.txt doesn't exist, create one
    if (!$Condition) {
    New-Item C:\documents\survey.txt -type file } 
    # clear results of last survey
    Clear-Content C:\documents\survey.txt
    
    #Write Computer name into survey.txt
    Add-Content -Path C:\documents\survey.txt -Value "Computer Name: $env:COMPUTERNAME `r`n"
    
    #Write Date/Time into survey.txt
    $Date = Get-Date
    Add-Content -Path C:\documents\survey.txt -Value "Date/Time: $Date `r`n"
    
    #Write OS Version into survey.txt
    $Version=(Get-WmiObject -class Win32_operatingsystem) | select Version
    Add-Content -Path C:\documents\survey.txt -Value "OS Version: $Version `r`n"
    
    #List all processes with session ID = 0 into survey.txt
    $Processes0=Get-Process | Where-Object {$_.SessionId -eq 0}
    Add-Content -Path C:\documents\survey.txt -Value "All processes with session ID=0 : `r`n $Processes0 `r`n"
    
    #List all processes with session ID = 1 into survey.txt
    $Processes1=Get-Process | Where-Object {$_.SessionId -eq 1}
    Add-Content -Path C:\documents\survey.txt -Value "All processes with session ID=1 : `r`n $Processes1 `r`n"
   
    #List all open sockets into survey.txt
    $OpenSockets = netstat -an
    Add-Content -Path C:\documents\survey.txt -Value "Open sockets are: `r`n $OpenSockets `r`n"

    echo "Go to C:\documents\surevey.txt to find the survey results"
    echo "Please note that all contents of this file will be cleared in the next survey"
    echo "So, if you need to keep this survey info, save the text file as any name other than survey.txt to avoid loss of data"
}

if ($hashdir) {
    #Ask the user for the directory of the files to be hashed
    $dir= Read-Host -Prompt 'Type the path of the files that you want to hash'
    #test if user input is a valis path
    $condition = Test-Path $dir
    #if not valid ask the user again for a valid path
    while (!$condition) {
        $dir= Read-Host -Prompt 'Type the full path, make sure it is in the right form'
        $condition = Test-Path $dir
    }
     #checks if hashes.txt file exists in C:\documents folder
    $Condition=Test-Path C:\documents\hashes.txt
    
    # if hashes.txt doesn't exist, create one
    if (!$Condition) {
    New-Item C:\documents\hashes.txt -type file } 
    
    # clear results of last hashing
    Clear-Content C:\documents\hashes.txt

    #save the current working directory
    $WD = $PWD
    
    #change directory to the user's path input
    cd $dir
    
    #Get each file in the given path
    $myfiles = Get-ChildItem $dir
    
    #Hash every file in the given path
    foreach ($file in $myfiles) {
        #Check if directory or file
        $ISDIR = (Get-Item $file) -is [System.IO.DirectoryInfo]
        #if it's a directory get and hash its contents
        If ($ISDIR) {
            cd $file
            $mysubfiles = Get-ChildItem $file
            foreach ($subfile in $mysubfiles) {
            $hash=echo (hash-file($subfile))
            Add-Content -Path C:\documents\hashes.txt -Value "`r`n $hash `r`n"
            cd $WD
        }
        #if it's a file hash it
        else {
            $hash=echo (hash-file($file))
            Add-Content -Path C:\documents\hashes.txt -Value "`r`n $hash `r`n" 
        }
        }
    
    #switch back to your old directory
    cd $WD

    echo "Go to C:\documents\hashes.txt to find the hashing results"
    echo "Please note that all contents of this file will be cleared in the next hashing process"
    echo "So, if you need to keep these hashes info, save the text file as any name other than hashes.txt to avoid loss of data"

}
}

if ($help) {
    echo "This function has three switches: "
    echo "-survey: used to run a basic baselining survey on your computer"
    echo "-hashdir: used to hash any file by typing the file's full path"
    echo "-help: show this help page" 
}
}

function hash-file ($file) {
    $hashf = Get-FileHash $file -Algorithm MD5
    return $hashf
}

function custom {

param(
    [switch] $linux,
    [switch] $windows)

if ($linux) {
echo""
echo""
echo""
echo "|             | |\            | |           |  \          /"
echo "|             | | \           | |           |   \        /"
echo "|             | |  \          | |           |    \      /"
echo "|             | |   \         | |           |     \    /"
echo "|             | |    \        | |           |      \  /"
echo "|             | |     \       | |           |       \/"
echo "|             | |      \      | |           |       /\"
echo "|             | |       \     | |           |      /  \"
echo "|             | |        \    | |           |     /    \"
echo "|             | |         \   | |           |    /      \"
echo "|             | |          \  | |           |   /        \"
echo "|             | |           \ | |           |  /          \"
echo "|_ _ _ _ _ _  | |            \| |_ _ _ _ _ _| /            \"
echo ""
echo "   __________         ____________  "
echo "| |                  |              |            | |\            |"
echo "| |                  |              |            | | \           |"
echo "| |                  |              |            | |  \          |"
echo "| |                  |              |            | |   \         |"
echo "| |                  |____________  |            | |    \        |"
echo "| |_________         |              |            | |     \       |"
echo "|           |        |              |            | |      \      |"
echo "|           |        |              |            | |       \     |"
echo "|           |        |              |            | |        \    |"
echo "|           |        |              |            | |         \   |"
echo "|           |        |              |            | |          \  |"
echo "|           |        |              |            | |           \ |"
echo "| __________|        |              |____________| |            \|"

}

if ($windows) {
echo""
echo""
echo""
echo "                                    ________       ________                      __________"
echo "|              | | |\            | |        \     /        \   |              | |"
echo "|              | | | \           | |         \   /          \  |              | |"
echo "|              | | |  \          | |          | |            | |              | |"
echo "|              | | |   \         | |          | |            | |              | |"
echo "|              | | |    \        | |          | |            | |              | |"
echo "|              | | |     \       | |          | |            | |              | |_________"
echo "|      /\      | | |      \      | |          | |            | |      /\      |           |"
echo "|     /  \     | | |       \     | |          | |            | |     /  \     |           |"
echo "|    /    \    | | |        \    | |          | |            | |    /    \    |           |"
echo "|   /      \   | | |         \   | |          | |            | |   /      \   |           |"
echo "|  /        \  | | |          \  | |          | |            | |  /        \  |           |"
echo "| /          \ | | |           \ | |         /   \          /  | /          \ |           |"
echo "|/            \| | |            \| |_______ /     \________/   |/            \| __________|"
echo ""
echo "   __________         ____________  "
echo "| |                  |              |            | |\            |"
echo "| |                  |              |            | | \           |"
echo "| |                  |              |            | |  \          |"
echo "| |                  |              |            | |   \         |"
echo "| |                  |____________  |            | |    \        |"
echo "| |_________         |              |            | |     \       |"
echo "|           |        |              |            | |      \      |"
echo "|           |        |              |            | |       \     |"
echo "|           |        |              |            | |        \    |"
echo "|           |        |              |            | |         \   |"
echo "|           |        |              |            | |          \  |"
echo "|           |        |              |            | |           \ |"
echo "| __________|        |              |____________| |            \|"
}
}

function services {

param (
 [switch] $all,
 [switch] $running,
 [switch] $stopped,
 [switch] $search)

#list all services
if ($all) {
    Get-Service
    }
    
#list all running services
if ($running) { 
    Get-Service | Where-Object {$_.Status -eq "Running"}
    }
# List all stopped services
if ($stopped) {
    Get-Service | Where-Object {$_.Status -eq "Stopped"}
}

#search services by name
if ($search) {
     $name= Read-Host -Prompt 'Type the name of the service that you are looking for'
     Get-Service | Where-Object {$_.Name -eq $name}
    
}
}

function guess {

param (
    [switch] $help)

    $num = Get-Random -Minimum 0 -Maximum 1000
    $guess= Read-Host -Prompt 'Guess the number'
    $condition="1"
    while ($condition="1") {
        if ($guess -gt $num) {
            echo "Less"
            $guess= Read-Host -Prompt 'Guess the number'
        }
        elseif ($guess -lt $num) {
            echo "More"
            $guess= Read-Host -Prompt 'Guess the number'
        }
        elseif ($guess -eq $num) {
            echo "You got it"
            $condition="0"
            break
        }
    }
    if ($help) {
        echo "Guess the number that is in the 0-1000 range"
    }
}