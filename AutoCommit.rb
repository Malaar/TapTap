

# To commit your project changes into remote repo

commitMessage = "autocommit";

system('git add .');
system('git status -s');
system("git commit -a -m '#{commitMessage}'");
system('git pull origin master');
system('git push origin master');
#system('');