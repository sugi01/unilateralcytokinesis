# Contractile ring closure analysis

This repository contains ImageJ macros and Jupyter notebooks used for the analysis of embryo cleavage in a research project.

## Prerequisites
1. Fiji
2. Jupyter notebook
3. Morpholib J plug-in for Image J (https://imagej.net/plugins/morpholibj)
4. Attenuation correction plug-in for Image J 


## ImageJ Macros

### Step1-Hyperstackfor31Z.ijm

This macro creates a hyperstack from an image stack with two channels, 31 slices, and n frames. The user should modify the number based on their image type.

### Step2-Attenuationcorrection-timelapse.ijm

This macro applies a Gaussian blur and attenuation correction plug-in to each frame and saves the result in an "attenuatedimages" folder. Before using this macro, the user should orient the hyperstack built in Step 1 so that the anterior and posterior of the embryo are to the left and right, respectively.

### Step3-Morphologicalsegmentation.ijm

1. Open the folder containing attenuated images.
2. Move the box to the cleavage site and click OK.
3. 3D projection will be done.
4. Select ring en face view and click OK.
5. Select the best segmentation results and create "catchment basin" image.
6. Enter the label number of the segmented image (you can check by mouse over).



### Step4-Contractileringanalysis.ijm

This macro does measurement of segmented data. Before running, modify the folder name to which you want to save the result table (at the bottom of the macro). Open segmented data after running. Later analysis will be done using Jupyter notebook.

### Step5-SpindlemaskingforPIV.ijm

This macro masks the cytoplasmic region containing the spindle. The processed files are automatically saved to the same folder.

### Step6-PIVprojectionleadingandlaggingviews.ijm

This macro creates a 3D projection of the spindle-masked stack. 
1. After running, adjust the intensity value and click OK.
2. Enter the number from the text file created in Step 4. The text file contains "Add number Z" cells in each row which represents the orientation of closure. Enter the number from there at the relevant time point. In our paper, we selected the number when the relative diameter (second columns) exceeded 25 (25% closure). It automatically saves leading and lagging edge views. 
3. You need to do quality control at this step.

### Step7-SaveimagesequenceforPIV.ijm

This macro saves an image sequence for PIVLab (a sequence of TIFF images).

### Trajectorymaker.ijm

This macro creates a color-coded ring trajectory using the segmented data.

### Polarbodyeraser.ijm

This macro erases the polar body from the user-defined region (fill 0 values in the area after the selected frames). Useful for AB cell.

### Myosin-raw-ringmaker.ijm

While we have used attenuation-corrected image for segmentation, we need to quantify myosin signal using raw data. In this case, we created the 3D projection of the ring using this macro. Note that still interpolation will be applied and your image will be modified. Also, setMinAndMax in line 9 should be modified so that the maximum is not exceeding your samples' max intensity (in our case, ani-1(RNAi) ring's maximum were near 1700 intensity so that it was set to 1700).

### Myosin-quantification.ijm

This macro quantifies the myosin raw ring image created in Step 10 using the segmentation data created in Step 3. Before running, modify the saving folder.

## Jupyter Notebooks

### Ringdata.ipynb

This code reads text files created in Step 4 and does time alignment relative to 10% closure, calculate ring velocity, time lag, normalized time lag, and peak eccentricity.

### Flowdata.ipynb

This code reads PIV csv files created in MatLab PIVLab and calculate convergence. Also this code calculate mean convergence in a region of interest (center, left, and right relative to the cleavage site). "xcen" and "ycen" are user-defined location of the center of the cleavage site. convxfc represents A-P convergence in the center. ufl represents A-P flow in the left side. This code also does time alignment relative to 10% closure and calculate normalized flow velocity and peak flow velocity and peak convergence.

<!-- USAGE EXAMPLES -->

<!-- LICENSE -->
## License

Distributed under the BSD-3-Clause license. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

- sugioka@zoology.ubc.ca


<p align="right">(<a href="#readme-top">back to top</a>)</p>








<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/github_username/repo_name.svg?style=for-the-badge
[contributors-url]: https://github.com/github_username/repo_name/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/github_username/repo_name.svg?style=for-the-badge
[forks-url]: https://github.com/github_username/repo_name/network/members
[stars-shield]: https://img.shields.io/github/stars/github_username/repo_name.svg?style=for-the-badge
[stars-url]: https://github.com/github_username/repo_name/stargazers
[issues-shield]: https://img.shields.io/github/issues/github_username/repo_name.svg?style=for-the-badge
[issues-url]: https://github.com/github_username/repo_name/issues
[license-shield]: https://img.shields.io/github/license/github_username/repo_name.svg?style=for-the-badge
[license-url]: https://github.com/github_username/repo_name/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username
[product-screenshot]: images/screenshot.png
[Next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Next-url]: https://nextjs.org/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
[Vue.js]: https://img.shields.io/badge/Vue.js-35495E?style=for-the-badge&logo=vuedotjs&logoColor=4FC08D
[Vue-url]: https://vuejs.org/
[Angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white
[Angular-url]: https://angular.io/
[Svelte.dev]: https://img.shields.io/badge/Svelte-4A4A55?style=for-the-badge&logo=svelte&logoColor=FF3E00
[Svelte-url]: https://svelte.dev/
[Laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white
[Laravel-url]: https://laravel.com
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[JQuery-url]: https://jquery.com 
