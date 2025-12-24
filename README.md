# Programming-Assignment-2
  SHORT SUMMARY OF DEBOUNCING AND METHOD USED
  
   Debouncing is important because a button press is not stable. When a mechanical pushbutton is pressed, the electrical signal does not change cleanly from OFF to ON; instead, it rapidly switches ON and OFF several times before finally settling. If the system reads the button during this bouncing period, it may incorrectly interpret a single press as multiple presses, which can lead to problems such as incorrect counting, unintended resets, or unstable system behavior. 

  To address this issue, I implemented software debouncing using a delay loop in my code. After detecting a button press, the program waits for a short period before continuing, allowing the button signal to settle and become stable. I used a delay constant of 40000, which produces a delay of a few milliseconds on the ARM DE1-SoC. This duration is long enough to eliminate the effects of bouncing but short enough that the system still feels responsive to the user. This method is simple and reliable, making it well-suited for a beginner-level embedded system, and it ensures that one physical button press results in one correct and predictable action.

  YouTube Video
 Part 1 https://youtu.be/oM1KwRHlEWI?si=uOq6K30gaAdxg8k1
Part 2 https://youtu.be/rq8yUyOOTaw?si=sTKhD08ewh_k0Ua9
Part 3 https://youtu.be/MNCrTgK2yOg?si=PPW-tnYEfEj-COXQ
  
