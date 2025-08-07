"use client";

import React, { useCallback, useEffect, useState } from "react";
import useEmblaCarousel, { EmblaOptionsType } from "embla-carousel-react";
import Autoplay from "embla-carousel-autoplay";
import { motion } from "motion/react";
import { cn } from "@/lib/utils";
import { useCarouselButtons, PrevButton, NextButton } from "./carousel-button";
import { useCarouselIndicator, CarouselIndicator } from "./carousel-indicator";

export interface MagicCarousel2Props {
  className?: string;
  slides: React.ReactNode[];
  options?: EmblaOptionsType;
  maxRotateX?: number;
  maxRotateY?: number;
  maxScale?: number;
  tweenFactorBase?: number;
  autoplay?: boolean;
  autoplayDelay?: number;
  showIndicators?: boolean;
  showArrows?: boolean;
}

export const MagicCarousel2: React.FC<MagicCarousel2Props> = ({
  className,
  slides,
  options,
  maxRotateX = 45,
  maxRotateY = 15,
  maxScale = 0.9,
  tweenFactorBase = 0.7,
  autoplay = true,
  autoplayDelay = 2000,
  showIndicators = true,
  showArrows = true,
}) => {
  const [emblaRef, emblaApi] = useEmblaCarousel(
    {
      loop: true,
      align: "center",
      skipSnaps: false,
      ...options,
    },
    autoplay
      ? [Autoplay({ delay: autoplayDelay, stopOnInteraction: true })]
      : []
  );

  const {
    prevBtnDisabled,
    nextBtnDisabled,
    onPrevButtonClick,
    onNextButtonClick,
  } = useCarouselButtons(emblaApi);

  const { selectedIndex, scrollSnaps, onDotButtonClick } =
    useCarouselIndicator(emblaApi);

  const [tweenValues, setTweenValues] = useState<number[]>([]);

  const onScroll = useCallback(() => {
    if (!emblaApi) return;

    const engine = emblaApi.internalEngine();
    const scrollProgress = emblaApi.scrollProgress();
    const styles = emblaApi.slideNodes().map((_, index) => {
      const slideProgress = engine.scrollProgress.get(index);
      const diffToTarget = scrollProgress - slideProgress;
      const tweenValue = 1 - Math.abs(diffToTarget * tweenFactorBase);
      return Math.max(tweenValue, 0);
    });
    setTweenValues(styles);
  }, [emblaApi, tweenFactorBase]);

  useEffect(() => {
    if (!emblaApi) return;
    onScroll();
    emblaApi.on("reInit", onScroll).on("scroll", onScroll);
    return () => {
      emblaApi?.off("reInit", onScroll).off("scroll", onScroll);
    };
  }, [emblaApi, onScroll]);

  return (
    <div className={cn("relative", className)}>
      <div className="overflow-hidden" ref={emblaRef}>
        <div className="flex">
          {slides.map((slide, index) => {
            const tweenValue = tweenValues[index] || 0;
            const rotateX = (1 - tweenValue) * maxRotateX;
            const rotateY =
              (1 - tweenValue) * maxRotateY * (index % 2 === 0 ? 1 : -1);
            const scale = tweenValue * (1 - maxScale) + maxScale;

            return (
              <motion.div
                key={index}
                className="flex-[0_0_80%] min-w-0 pl-4 relative"
                style={{
                  willChange: "transform",
                }}
                animate={{
                  rotateX,
                  rotateY,
                  scale,
                }}
                transition={{
                  type: "tween",
                  ease: "easeOut",
                  duration: 0.3,
                }}
              >
                <div className="h-full select-none">{slide}</div>
              </motion.div>
            );
          })}
        </div>
      </div>

      {showArrows && (
        <>
          <PrevButton
            className={cn(
              "absolute left-4 top-1/2 -translate-y-1/2 z-10",
              "w-12 h-12 rounded-full bg-background/80 backdrop-blur-sm",
              "border border-border hover:bg-background",
              "transition-all duration-200 hover:scale-110",
              "disabled:opacity-50 disabled:cursor-not-allowed",
              "flex items-center justify-center text-foreground"
            )}
            onClick={onPrevButtonClick}
            disabled={prevBtnDisabled}
          />
          <NextButton
            className={cn(
              "absolute right-4 top-1/2 -translate-y-1/2 z-10",
              "w-12 h-12 rounded-full bg-background/80 backdrop-blur-sm",
              "border border-border hover:bg-background",
              "transition-all duration-200 hover:scale-110",
              "disabled:opacity-50 disabled:cursor-not-allowed",
              "flex items-center justify-center text-foreground"
            )}
            onClick={onNextButtonClick}
            disabled={nextBtnDisabled}
          />
        </>
      )}

      {showIndicators && (
        <div className="flex justify-center gap-2 mt-8">
          {scrollSnaps.map((_, index) => (
            <CarouselIndicator
              key={index}
              className={cn(
                "w-2 h-2 rounded-full transition-all duration-300",
                index === selectedIndex
                  ? "bg-primary w-8"
                  : "bg-primary/30 hover:bg-primary/50"
              )}
              onClick={() => onDotButtonClick(index)}
              aria-label={`Go to slide ${index + 1}`}
            />
          ))}
        </div>
      )}
    </div>
  );
};
