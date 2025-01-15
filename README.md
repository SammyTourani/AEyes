## Sightsense

## Technical Description
Sightsense is a real-time computer vision tool designed to assist visually impaired users by recognizing objects, reading text, and delivering spoken feedback. It combines optical character recognition (OCR), an object detection model, and a text-to-speech engine to transform live camera input into meaningful audio cues.

**Core Components**  
- **Camera Input**  
  Uses a webcam or device camera to capture video frames. The default implementation leverages OpenCV to access and read frames from the camera feed.  
- **Object Detection**  
  A pretrained model, configured within the repository, processes each captured frame and draws bounding boxes or labels around recognized items (for example, YOLO or TensorFlow-based models).  
- **Text Recognition**  
  Integrates an OCR library (such as Tesseract) to parse text within the frame and return recognized strings.  
- **Text-to-Speech Engine**  
  Converts the recognized labels and text into audio output. Depending on the user’s environment, the code might leverage libraries like pyttsx3, gTTS, or a cloud TTS API.

## Architecture
1. **Frame Acquisition**  
   - Continuously reads camera frames.  
   - Passes raw images to the processing pipeline.  
2. **Processing Pipeline**  
   - **Object Detection:** Processes each frame, identifies objects, and returns detection results (class labels, confidence scores, bounding box coordinates).  
   - **OCR Module (Conditional):** If enabled, crops relevant regions containing text and applies OCR to extract text data.  
3. **Output Generation**  
   - Merges object detection results (and OCR findings if available) into a textual description.  
   - Uses a text-to-speech engine to generate human-audible feedback.  
4. **Real-Time Feedback Loop**  
   - Plays the generated audio description.  
   - Continues acquiring subsequent frames.

## Repository Structure
| Folder/File       | Description                                                                 |
|:-----------------|:----------------------------------------------------------------------------|
| src/             | Contains the primary vision processing scripts and object detection logic.   |
| src/ocr/         | Houses OCR-related utility functions or Tesseract wrapper scripts.           |
| src/audio/       | Implements the text-to-speech functionality, including engine setup.         |
| requirements.txt | Specifies all Python dependencies needed for object detection, OCR, and audio. |
| main.py          | Entry point to launch camera acquisition, run inferences, and output audio.  |

## Installation and Setup
1. Clone the repository.  
2. Install required Python packages:  
