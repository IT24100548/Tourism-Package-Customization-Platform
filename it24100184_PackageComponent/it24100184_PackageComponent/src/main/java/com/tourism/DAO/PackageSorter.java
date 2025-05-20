package com.tourism.DAO;

import com.tourism.model.TravelPackage;

import java.util.List;

public class PackageSorter {
    public static void quickSortByPrice(List<TravelPackage> list, int low, int high) {
        if (low < high) {
            int pi = partition(list, low, high);
            quickSortByPrice(list, low, pi - 1);
            quickSortByPrice(list, pi + 1, high);
        }
    }

    private static int partition(List<TravelPackage> list, int low, int high) {
        double pivot = list.get(high).getPrice();
        int i = low - 1;

        for (int j = low; j < high; j++) {
            if (list.get(j).getPrice() < pivot) {
                i++;
                swap(list, i, j);
            }
        }

        swap(list, i + 1, high);
        return i + 1;
    }

    private static void swap(List<TravelPackage> list, int i, int j) {
        TravelPackage temp = list.get(i);
        list.set(i, list.get(j));
        list.set(j, temp);
    }
}