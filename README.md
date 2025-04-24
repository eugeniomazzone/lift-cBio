# Usage
To perform the liftover for study mutations do:
```
Rscript fetch.r <study-id>
Rscript lift.r <study-id>
```

To perform the liftover for study structural variant do:
```
Rscript fetch-sv.r <study-id>
Rscript lift-sv.r <study-id>
```

# Setup
Be sure to have the chain file needed, you can download it by running:
```
Rscript chain.r
```

# Change assembly
This will get the chain for lifting from Hg38 to Hg19.
If you want to make a different liftover, change name in lift.r and chain.r accordingly.

# Requirements
Be sure to have installed the R library required:
```
library(cbioportalR)
library(liftOver)
library(RCurl)

```
