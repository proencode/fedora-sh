#!bin/sh

diff_a_b () {
	echo "#-- ----"
	diff ${a} ${b}
	echo "#-- diff ${a}"
	echo "#--      ${b}"
	echo "#-- --------------------"
}

diff_b_a () {
	echo "#-- ----"
	diff ${b} ${a}
	echo "#-- diff ${b}"
	echo "#--      ${a}"
	echo "#-- --------------------"
}

cat <<__EOF__

cd /home/orangepi/git-projects/fedora-sh/12-markdown-Archive/

__EOF__
cd /home/orangepi/git-projects/fedora-sh/12-markdown-Archive/

#--

a=../../fedora-sh/md-230522-learn_spring_for_android_application_development/md-gen/func-key-setting.vi
b=md_made_ing/old_files/func-key-setting.vi
diff_a_b
a=md_made_ing/ff-func-key-setting.vi
diff_b_a
b=packtpub/inkscapeByExample/md_made_ing/func-key-setting.vi
diff_a_b
a=packtpub/y2022/101_Kotlin_Design_Patterns_230807/md_made_ing/func-key-setting.vi
diff_b_a
b=packtpub/y2023/501_How_to_Build_230809/md_made_ing/func-key-setting.vi
diff_a_b
a=packtpub/y2023/301-WordPress_Web_Application_230901/script_made_ing/func-key-setting.vi
diff_b_a
b=packtpub/y2023/701_modern_android_13_230811/script_made_ing/func-key-setting.vi
diff_a_b
a=packtpub/y2023/aa2023-01/Javascript_from_Frontend_to_Backend_2207/md_made_ing/func-key-setting.vi
diff_b_a
b=packtpub/y2023/aa2023-01/Learn_Spring_for_Android_AppDev_1901/md_made_ing/func-key-setting.vi
diff_a_b
a=packtpub/y2023/aa2023-01/Building_Applications_with_Spring_5_and_Vue_js_2_1810/md_made_ing/func-key-setting.vi
diff_b_a
b=packtpub/y2023/aa2023-01/Learning_Spring_Boot_3.0_Third_Edition_2212/md_made_ing/func-key-setting.vi
diff_a_b
a=packtpub/y2023/ab2023-02/Mastering_Vim_230201/md_made_ing/func-key-setting.vi
diff_b_a
b=packtpub/2024/qqq/md_made_ing/ff-func-key-setting.vi
diff_a_b
a=packtpub/2024/422-Web_Development_with_Django/trash-files/md_made_ing/ff-func-key-setting.vi
diff_b_a
b=packtpub/2024/422-Web_Development_with_Django/trash-files/original-copy/old_files/ff-func-key-setting.vi
diff_a_b
a=packtpub/2024/201-coliss-LinuxCommandLine_ShellScriptingTechniques/md_made_ing/func-key-setting.vi
diff_b_a
b=packtpub/2024/730-Django_5_by_Example_5ed/func-key-setting.vi
diff_a_b
a=func-key-setting.vi
diff_b_a
