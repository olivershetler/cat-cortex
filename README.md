# READ ME

This repository has the code required to reproduce the results in my [article](https://oliver.shetler.org/cat-cortex), which analyzes neural spike train data from a cat's visual cortex.

The data for this project and many other wonderful data sets are available at [crcns.org](https://crcns.org/).

## Scripts

In brief, these are the scripts and how to use them:

(1) `MakeFrequencyCSVs.R`

This script makes the CSV files stored in the `./data/csv` directory from the data stored in the `./data/original` directory. For more details about the data, please refer to the section entitled 'The ./data/ Directory.'

You DO NOT have to run this file to use the rest of the scripts, as pre-made CSV files are included in this repository.

(2) `AnalyzeFrequencyDistributions.R`

This script analyzes the frequency distributions of the spike trains in the CSV files in the `./data/csv` directory. Four models are used on frequency data at different time resolutions. For more details on the specific models and time-scales, see the Methods and Results section of data analysis [article](./article.pdf) in this repository.


(3) `MakeInterSpikeIntervalPlots.R`




## Compatibility

This project relies on the following R libraries:
- tidyverse (and its dependencies)
-

In order to ensure the portability of this repository, every R file has a function called `getParentDirectory()` which was inspired by this [Stack Overflow thread](https://stackoverflow.com/questions/47044068/get-the-path-of-current-script). I have not tested the function on Windows and Mac. I do not expect any problems, but there might be compatibility issues. In particular, since this repository was built on the Ubuntu Linux operating system (v 21.10), relative file paths are written using forward slashes. It is possible, especially on Windows, that the output of `getParentDirectory()` could produce backward slashes that are incompatible with with the convention for the relative paths. Therefore, if any file location errors arise, please try printing the file paths to check for slash issues as a first line of defence.


## The ./data/ Directory

The data directory contains all the original and derivative data files for the project. There are two subdirectories: `original` and `csv`.

### ./data/csv

The `./data/csv` directory contains CSV files generated from the `MakeFrequencyCSVs.R` script. These data sets contain spike counts inside of temporal buckets of varying sizes (one file per time-scale). Each CSV file contains columns every channel, and an additional column for the experimental condition from which the spike counts were extracted. In other words, each CSV file is a panel data set that concatinates spike counts from each experimental condition, aggregated over all the channels. This format allows for regression analysis. (See the following section for more details on the original data)

### ./data/original

The `./data/original` directory contains the original [pvc-3 data set](https://crcns.org/data-sets/vc/pvc-3) from the CRCNS repository, along with PDF files with documentation. Check out the `crcns-pvc3-summary.pdf` file for an overview of the experiment that the scientists conducted. Look at the `crcns-pvc3-userguide.pdf` for information on any files or context not discussed in detail below. Fair warning, some of the documentation is incomplete. Additionally, there is a confusing section about primate data in the userguide. The scientists had done a concurrent experiment with monkeys, but data from those procedures were not included in the pvc-3 data set. You can safely ignore that information.

The `original` folder contains four sub-directories.
- `drifting_bar`
- `natural_movie`
- `spont_activity`
- `white_noise`

#### ./data/original/drifting_bar

The `drifting_bar` folder contains experimental data from when the cat was watching a movie of drifting bars. It contains two subdirectories: `spike_data` and `stimulus_data`.

The `spike_data` folder contains spike train data extracted from electrodes redundantly stored in both `.dat` and `.tem` formats. In the online repository, the `.dat` files were originally given the custom file extension `.spk`. They were re-named using regular expressions in order to make them readable using the `readBin(..)` function in the `MakeFrequencyCSVs.R` script. These files contain the spike time-stamps extracted from the polytrode data.

 Additionally, the `spike_data` file contains four support files
- `polytrode_2a.pas`
- `polytrode_2a.tif`
- `spk_info.txt`
- `spk_templates_olay.tif`

The `spk_info.txt` file contains some helpful information about how the binary spike files are encoded. The most notable information is that the data are encoded using the `int64` (64 bit integer) data type and that the time-stamp precision is 1E-5 but it is recorded in 1E-6*second units.

The `polytrode_2a.tif` contains a diagram of the polytrode implant that was used to gather the spike train data. The `spk_templates_olay.tif` file contains an overlay image which may be intended for `polytrode_2a.tif`. I do not know what the `.pas` file is for.

The `stimulus_data` folder contains three files
- drifting_bar.din
- drifting_bar.py
- stim_info.txt

The `stim_info.txt` file contains information about how the `drifting_bar.din` file is encoded. It says that there are time-stamps of type `int64` with a precision of 4E-5 in 1E-6*second units. Moreover, there are 16 distinctions regarding the angle/placement of the drifting bar.

The `drifting_bar.din` file contains data encoded as shown above. Unlike the spike data (which only contains time-stamps for spikes), this data set contains a time-stamp and a number from 1-16 for every frame of the corresponding movie.

The `drifting_bar.py` file contains parameters that can theoretically be used to re-construct the movie that was shown to the cat. Unfortunately, the script depends on a very old python package (depends on python 2.6) called visionegg. I have attempted to get the script working but have not succeeded.

#### ./data/original/natural_movie

The `natural_movie` folder contains directories and files that almost exactly mirror the structure outlined above. The only difference is that the `stimulus_data` folder contains the following files
- ns2-64p-50h-2m-mn125-ct045.din
- ns2-64p-50h-2m-mn125-ct045.m
- ns2-64p-50h-2m-mn125-ct045.py
- stim_info.txt

The encoding of the `.din` file is identical to the `drifting_bars.din` file. However, this data set does not contain any meaningful covariate to the time-stamps because it corresponds to the frames of a head-cam movie from a cat moving around in its natural environment. The `.m` file contains the movie itself.

The contents of the `spike_data` folder is identical in structure to the one in the other two experimental condition folders (`drifting_bar` and `natural_movie`).


#### ./data/original/white_noise

Like above, the `white_noise` folder contains directories and files that almost exactly mirror the structure outlined above. The only difference is that the `stimulus_data` folder contains the following files
- wn2-64p-50h-2m-mn125-ct045.din
- wn2-64p-50h-2m-mn125-ct045.m
- wn2-64p-50h-2m-mn125-ct045.py
- stim_info.txt

The encoding of the `.din` file is identical to the other `din` files. However, like `natural_movie` this data set does not contain any meaningful covariate to the time-stamps because it corresponds to the frames randomely generated white noise. The `.m` file contains the movie itself, but I was not able to open it. In theorey the `.py` file should allow for the reconstruction of the movie, but as discussed above, the dependencies to run the file may be too old reconstruct.

The contents of the `spike_data` folder is identical in structure to the one in the other two experimental condition folders (`drifting_bar` and `natural_movie`).

#### ./data/original/spont_activity

Unlike the other (experimental) files, the `spont_activity` file contains spike data. It contains two folders called
- spike_data_area17
- spike_data_area18

The data were not used in my analysis, so I don't have much information about the contents of these folders. The only thing worth mentioning is that they contain more channels than the other folders, but they are also missing some of the final channels (hence why the data were not included in my analysis). A future elaboration on this project could include these data, with models that can handle missing data (imputation, etc.). Feel free to poke around if the data interest you.